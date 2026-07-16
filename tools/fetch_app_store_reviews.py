#!/usr/bin/env python3
import argparse
import csv
import json
import subprocess
import sys
import time
from collections import Counter, defaultdict
from datetime import datetime, timedelta, timezone
from pathlib import Path
from urllib.parse import urlencode

import jwt


API_BASE = "https://api.appstoreconnect.apple.com/v1"


def build_url(path: str, params: dict[str, str | int]) -> str:
    return f"{API_BASE}{path}?{urlencode(params)}"


def build_token(key_id: str, issuer_id: str, key_path: Path) -> str:
    private_key = key_path.read_text()
    now = int(time.time())
    return jwt.encode(
        {"iss": issuer_id, "exp": now + 1200, "aud": "appstoreconnect-v1"},
        private_key,
        algorithm="ES256",
        headers={"kid": key_id, "typ": "JWT"},
    )


def fetch_json(url: str, token: str) -> dict:
    result = subprocess.run(
        [
            "curl",
            "--silent",
            "--show-error",
            "--fail-with-body",
            "-H",
            f"Authorization: Bearer {token}",
            "-H",
            "Accept: application/json",
            url,
        ],
        capture_output=True,
        text=True,
        check=False,
    )
    if result.returncode != 0:
        raise RuntimeError(result.stderr.strip() or result.stdout.strip())
    return json.loads(result.stdout)


def paginate(url: str, token: str):
    while url:
        payload = fetch_json(url, token)
        yield payload
        url = payload.get("links", {}).get("next")


def list_apps(token: str) -> list[dict]:
    apps = []
    url = build_url(
        "/apps",
        {"limit": 200, "fields[apps]": "name,bundleId,sku,primaryLocale"},
    )
    for page in paginate(url, token):
        apps.extend(page.get("data", []))
    return apps


def select_app(apps: list[dict], bundle_id: str | None, name_hint: str | None) -> dict:
    if bundle_id:
        for app in apps:
            if app["attributes"].get("bundleId") == bundle_id:
                return app
    if name_hint:
        lowered = name_hint.lower()
        exact = [
            app for app in apps if app["attributes"].get("name", "").lower() == lowered
        ]
        if len(exact) == 1:
            return exact[0]
        partial = [
            app
            for app in apps
            if lowered in app["attributes"].get("name", "").lower()
            or lowered in app["attributes"].get("bundleId", "").lower()
        ]
        if len(partial) == 1:
            return partial[0]
    raise RuntimeError("Unable to identify a unique app from the App Store Connect account.")


def fetch_reviews(app_id: str, token: str) -> list[dict]:
    reviews = []
    fields = ",".join(
        [
            "rating",
            "title",
            "body",
            "reviewerNickname",
            "createdDate",
            "territory",
        ]
    )
    url = build_url(
        f"/apps/{app_id}/customerReviews",
        {
            "limit": 200,
            "fields[customerReviews]": fields,
            "include": "response",
        },
    )
    for page in paginate(url, token):
        reviews.extend(page.get("data", []))
    return reviews


def normalize_review(review: dict) -> dict:
    attrs = review.get("attributes", {})
    created = attrs.get("createdDate")
    created_dt = None
    if created:
        created_dt = datetime.fromisoformat(created.replace("Z", "+00:00"))
    return {
        "id": review.get("id"),
        "rating": attrs.get("rating"),
        "title": attrs.get("title") or "",
        "body": attrs.get("body") or "",
        "nickname": attrs.get("reviewerNickname") or "",
        "territory": attrs.get("territory") or "",
        "createdDate": created,
        "createdAt": created_dt,
    }


def filter_reviews(reviews: list[dict]) -> tuple[list[dict], str]:
    if len(reviews) <= 250:
        return reviews, "all"

    cutoff = datetime.now(timezone.utc) - timedelta(days=365)
    selected = []
    seen = set()
    for review in reviews:
        keep = False
        created_at = review.get("createdAt")
        rating = review.get("rating") or 0
        if created_at and created_at >= cutoff:
            keep = True
        if rating in (1, 2):
            keep = True
        if keep and review["id"] not in seen:
            selected.append(review)
            seen.add(review["id"])
    return selected, "last_12_months_plus_1_2_star_all_time"


def month_key(dt: datetime | None) -> str:
    if not dt:
        return "unknown"
    return dt.strftime("%Y-%m")


def average_rating(reviews: list[dict]) -> float:
    ratings = [r["rating"] for r in reviews if isinstance(r.get("rating"), int)]
    return sum(ratings) / len(ratings) if ratings else 0.0


def detect_version(text: str) -> str | None:
    import re

    match = re.search(r"\b(?:v(?:ersion)?\s*)?(\d+(?:\.\d+){0,3})\b", text, re.I)
    return match.group(1) if match else None


THEMES = [
    ("Crashes / stability", "bug", ["crash", "freeze", "stuck", "bug", "broken", "hang", "blank", "won't open", "wont open"]),
    ("Ads / interruptions", "bug", ["ad", "ads", "advert", "popup", "pop-up", "interstitial"]),
    ("Difficulty / AI balance", "sentiment", ["hard", "easy", "difficulty", "ai", "computer", "impossible", "too strong", "too easy"]),
    ("Rules / move clarity / UX confusion", "sentiment", ["rule", "legal move", "cannot move", "confus", "hint", "tutorial", "how to", "why can't"]),
    ("Performance / battery", "bug", ["slow", "lag", "battery", "hot", "heating", "drain"]),
    ("Feature requests", "feature", ["wish", "please add", "feature", "would like", "could you", "need", "want", "multiplayer", "theme", "dark mode", "undo"]),
    ("Praise / enjoyment", "sentiment", ["love", "great", "fun", "awesome", "good game", "beautiful", "nice", "excellent"]),
]


def classify_review(review: dict) -> list[tuple[str, str]]:
    text = f"{review['title']} {review['body']}".lower()
    matches = []
    for theme, kind, keywords in THEMES:
        if any(keyword in text for keyword in keywords):
            matches.append((theme, kind))
    if not matches:
        if (review.get("rating") or 0) >= 4:
            matches.append(("Praise / enjoyment", "sentiment"))
        else:
            matches.append(("Other feedback", "sentiment"))
    return matches


def short_quote(review: dict) -> str:
    text = (review["body"] or review["title"]).strip().replace("\n", " ")
    if len(text) > 120:
        text = text[:117] + "..."
    return text


def summarize(reviews: list[dict]) -> dict:
    distribution = Counter(r["rating"] for r in reviews if r.get("rating"))
    months = defaultdict(list)
    for r in reviews:
        months[month_key(r.get("createdAt"))].append(r)
    month_avg = {
        month: round(average_rating(items), 2)
        for month, items in sorted(months.items())
        if month != "unknown"
    }

    theme_reviews: dict[str, list[dict]] = defaultdict(list)
    theme_kind: dict[str, str] = {}
    for review in reviews:
        for theme, kind in classify_review(review):
            theme_reviews[theme].append(review)
            theme_kind[theme] = kind

    themes = []
    for theme, items in sorted(theme_reviews.items(), key=lambda kv: len(kv[1]), reverse=True):
        versions = Counter()
        territories = Counter()
        for item in items:
            version = detect_version(f"{item['title']} {item['body']}")
            if version:
                versions[version] += 1
            if item["territory"]:
                territories[item["territory"]] += 1
        quotes = []
        seen = set()
        for item in sorted(items, key=lambda r: (r.get("rating") or 0, r.get("createdDate") or "")):
            quote = short_quote(item)
            if quote and quote not in seen:
                quotes.append(
                    {
                        "quote": quote,
                        "rating": item.get("rating"),
                        "territory": item.get("territory"),
                        "date": item.get("createdDate"),
                    }
                )
                seen.add(quote)
            if len(quotes) >= 3:
                break
        themes.append(
            {
                "theme": theme,
                "kind": theme_kind[theme],
                "count": len(items),
                "ratings": dict(sorted(Counter(i["rating"] for i in items if i.get("rating")).items())),
                "versions": versions.most_common(5),
                "territories": territories.most_common(5),
                "quotes": quotes,
            }
        )

    return {
        "total": len(reviews),
        "distribution": dict(sorted(distribution.items())),
        "averageRating": round(average_rating(reviews), 2),
        "monthlyAverage": month_avg,
        "themes": themes,
    }


def write_csv(reviews: list[dict], path: Path) -> None:
    with path.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "id",
                "rating",
                "createdDate",
                "territory",
                "nickname",
                "title",
                "body",
            ],
        )
        writer.writeheader()
        for r in reviews:
            writer.writerow(
                {
                    "id": r["id"],
                    "rating": r["rating"],
                    "createdDate": r["createdDate"],
                    "territory": r["territory"],
                    "nickname": r["nickname"],
                    "title": r["title"],
                    "body": r["body"],
                }
            )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--issuer-id", required=True)
    parser.add_argument("--key-id", required=True)
    parser.add_argument("--key-path", required=True)
    parser.add_argument("--bundle-id")
    parser.add_argument("--name-hint")
    parser.add_argument("--out-json", required=True)
    parser.add_argument("--out-csv", required=True)
    args = parser.parse_args()

    token = build_token(args.key_id, args.issuer_id, Path(args.key_path))
    apps = list_apps(token)
    app = select_app(apps, args.bundle_id, args.name_hint)
    reviews = [normalize_review(r) for r in fetch_reviews(app["id"], token)]
    selected_reviews, selection_mode = filter_reviews(reviews)
    summary = summarize(selected_reviews)
    payload = {
        "app": {
            "id": app["id"],
            "name": app["attributes"].get("name"),
            "bundleId": app["attributes"].get("bundleId"),
            "sku": app["attributes"].get("sku"),
            "primaryLocale": app["attributes"].get("primaryLocale"),
        },
        "selectionMode": selection_mode,
        "allReviewCount": len(reviews),
        "analyzedReviewCount": len(selected_reviews),
        "summary": summary,
    }
    Path(args.out_json).write_text(json.dumps(payload, ensure_ascii=False, indent=2))
    write_csv(selected_reviews, Path(args.out_csv))
    print(
        json.dumps(
            {
                "appId": payload["app"]["id"],
                "name": payload["app"]["name"],
                "bundleId": payload["app"]["bundleId"],
                "allReviewCount": payload["allReviewCount"],
                "analyzedReviewCount": payload["analyzedReviewCount"],
                "selectionMode": payload["selectionMode"],
                "outJson": str(Path(args.out_json)),
                "outCsv": str(Path(args.out_csv)),
            },
            ensure_ascii=False,
        )
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
