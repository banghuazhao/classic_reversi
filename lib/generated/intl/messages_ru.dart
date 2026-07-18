// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(result, black, white, mode) =>
      "${result} · Чёрные ${black} – Белые ${white} (${mode}) — Classic Reversi";

  static String m1(wins, losses) => "Побед ${wins} · Поражений ${losses}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "AchDailyChallenge": MessageLookupByLibrary.simpleMessage("Чемпион дня"),
    "AchFirstWin": MessageLookupByLibrary.simpleMessage("Первая победа"),
    "AchGames10": MessageLookupByLibrary.simpleMessage("10 партий"),
    "AchGames50": MessageLookupByLibrary.simpleMessage("50 партий"),
    "AchPerfectGame": MessageLookupByLibrary.simpleMessage("Идеальная партия"),
    "AchWinHard": MessageLookupByLibrary.simpleMessage("Победа на сложном"),
    "AchWinStreak3": MessageLookupByLibrary.simpleMessage("Серия из 3"),
    "AchWinStreak5": MessageLookupByLibrary.simpleMessage("Серия из 5"),
    "AchievementUnlocked": MessageLookupByLibrary.simpleMessage(
      "Достижение открыто",
    ),
    "Achievements": MessageLookupByLibrary.simpleMessage("Достижения"),
    "AdFailed": MessageLookupByLibrary.simpleMessage(
      "Реклама недоступна. Попробуйте позже.",
    ),
    "AdLoading": MessageLookupByLibrary.simpleMessage("Загрузка рекламы…"),
    "AdsRemoved": MessageLookupByLibrary.simpleMessage("Реклама отключена"),
    "BestStreak": MessageLookupByLibrary.simpleMessage("Лучшая серия"),
    "Black": MessageLookupByLibrary.simpleMessage("чёрные"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("Чёрные побеждают"),
    "Cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "Classic_Reversi": MessageLookupByLibrary.simpleMessage(
      "Классические Реверси",
    ),
    "CurrentStreak": MessageLookupByLibrary.simpleMessage("Серия побед"),
    "DailyChallenge": MessageLookupByLibrary.simpleMessage("Ежедневный вызов"),
    "DailyChallengeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Пройдите сегодняшнюю задачу на сложном",
    ),
    "DailyCompleted": MessageLookupByLibrary.simpleMessage(
      "Сегодня выполнено — можно сыграть ещё",
    ),
    "Difficulty": MessageLookupByLibrary.simpleMessage("Сложность"),
    "DifficultyEasy": MessageLookupByLibrary.simpleMessage("Лёгкий"),
    "DifficultyHard": MessageLookupByLibrary.simpleMessage("Сложный"),
    "DifficultyMedium": MessageLookupByLibrary.simpleMessage("Средний"),
    "FirstPlayerComputer": MessageLookupByLibrary.simpleMessage("Компьютер"),
    "FirstPlayerHuman": MessageLookupByLibrary.simpleMessage("Игрок"),
    "FirstPlayerRandom": MessageLookupByLibrary.simpleMessage("Случайно"),
    "GameOver": MessageLookupByLibrary.simpleMessage("Игра окончена"),
    "GamesPlayed": MessageLookupByLibrary.simpleMessage("Сыграно партий"),
    "Haptics": MessageLookupByLibrary.simpleMessage("Вибрация"),
    "Hint": MessageLookupByLibrary.simpleMessage("Подсказка"),
    "HintsEnabled": MessageLookupByLibrary.simpleMessage(
      "Подсказки включены для этой игры.",
    ),
    "Home": MessageLookupByLibrary.simpleMessage("Домой"),
    "How_to_play": MessageLookupByLibrary.simpleMessage("Как играть?"),
    "How_to_play_explain": MessageLookupByLibrary.simpleMessage(
      "В игре все фишки соперника, лежащие по прямой линии между только что поставленной фишкой и другой фишкой текущего игрока, переворачиваются в цвет текущего игрока. Цель игры — к моменту заполнения последней свободной клетки иметь на доске большинство фишек своего цвета.",
    ),
    "More": MessageLookupByLibrary.simpleMessage("Ещё"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("Другие приложения"),
    "PerfectWins": MessageLookupByLibrary.simpleMessage("Идеальные победы"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage(
      "Играть с другом на этом устройстве",
    ),
    "PurchaseAlreadyOwned": MessageLookupByLibrary.simpleMessage(
      "У вас уже есть «Убрать рекламу».",
    ),
    "PurchaseCancelled": MessageLookupByLibrary.simpleMessage(
      "Покупка отменена.",
    ),
    "PurchaseFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось совершить покупку. Попробуйте ещё раз.",
    ),
    "PurchasePending": MessageLookupByLibrary.simpleMessage(
      "Покупка ожидает подтверждения…",
    ),
    "PurchaseSuccess": MessageLookupByLibrary.simpleMessage(
      "Реклама отключена. Спасибо!",
    ),
    "PurchaseUnavailable": MessageLookupByLibrary.simpleMessage(
      "Покупки сейчас недоступны.",
    ),
    "Rematch": MessageLookupByLibrary.simpleMessage("Ещё раз"),
    "RemoveAds": MessageLookupByLibrary.simpleMessage("Убрать рекламу"),
    "RestoreNothing": MessageLookupByLibrary.simpleMessage(
      "Нет покупок для восстановления.",
    ),
    "RestorePurchases": MessageLookupByLibrary.simpleMessage(
      "Восстановить покупки",
    ),
    "RestoreSuccess": MessageLookupByLibrary.simpleMessage(
      "Покупки восстановлены.",
    ),
    "Settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "Share": MessageLookupByLibrary.simpleMessage("Поделиться"),
    "ShareResult": m0,
    "Sound": MessageLookupByLibrary.simpleMessage("Звук"),
    "StartGame": MessageLookupByLibrary.simpleMessage("Начать игру"),
    "Stats": MessageLookupByLibrary.simpleMessage("Статистика"),
    "Theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "ThemeClassic": MessageLookupByLibrary.simpleMessage("Классика"),
    "ThemeContrast": MessageLookupByLibrary.simpleMessage("Контраст"),
    "ThemeNight": MessageLookupByLibrary.simpleMessage("Ночь"),
    "Tie": MessageLookupByLibrary.simpleMessage("Ничья"),
    "Ties": MessageLookupByLibrary.simpleMessage("Ничьи"),
    "TwoPlayersMode": MessageLookupByLibrary.simpleMessage(
      "2 игрока (по очереди)",
    ),
    "Watch": MessageLookupByLibrary.simpleMessage("Смотреть"),
    "WatchAd": MessageLookupByLibrary.simpleMessage("Смотреть рекламу"),
    "WatchAdForHint": MessageLookupByLibrary.simpleMessage(
      "Посмотрите короткую рекламу, чтобы показать ходы.",
    ),
    "WatchAdForUndo": MessageLookupByLibrary.simpleMessage(
      "Посмотрите короткую рекламу, чтобы отменить ход.",
    ),
    "White": MessageLookupByLibrary.simpleMessage("белые"),
    "WhiteWins": MessageLookupByLibrary.simpleMessage("Белые побеждают"),
    "WhoGoesFirst": MessageLookupByLibrary.simpleMessage("Кто ходит первым?"),
    "WinRate": MessageLookupByLibrary.simpleMessage("Процент побед"),
    "WinsByDifficulty": MessageLookupByLibrary.simpleMessage(
      "Победы по сложности",
    ),
    "WinsLosses": m1,
    "YouLose": MessageLookupByLibrary.simpleMessage("Вы проиграли"),
    "YouWin": MessageLookupByLibrary.simpleMessage("Вы победили!"),
  };
}
