// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a id locale. All the
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
  String get localeName => 'id';

  static String m0(coordinate, piece) => "${coordinate}, ${piece}";

  static String m1(color) => "Komputer · ${color}";

  static String m2(status, black, white) =>
      "${status}. Hitam ${black}, Putih ${white}.";

  static String m3(color) => "Giliran ${color}";

  static String m4(black, white) => "Sudut · Hitam ${black} · Putih ${white}";

  static String m5(move, total) => "Langkah ${move} dari ${total}";

  static String m6(result, black, white, mode) =>
      "${result} · Hitam ${black} – Putih ${white} (${mode}) — Classic Reversi";

  static String m7(passed, current) =>
      "${passed} tidak memiliki langkah yang sah. ${current} bermain lagi.";

  static String m8(step, total) => "Pelajaran ${step} dari ${total}";

  static String m9(wins, losses) => "Menang ${wins} · Kalah ${losses}";

  static String m10(color) => "Anda · ${color}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "Accessibility": MessageLookupByLibrary.simpleMessage("Aksesibilitas"),
    "AchDailyChallenge": MessageLookupByLibrary.simpleMessage("Juara harian"),
    "AchFirstWin": MessageLookupByLibrary.simpleMessage("Kemenangan pertama"),
    "AchGames10": MessageLookupByLibrary.simpleMessage("10 permainan"),
    "AchGames50": MessageLookupByLibrary.simpleMessage("50 permainan"),
    "AchPerfectGame": MessageLookupByLibrary.simpleMessage(
      "Permainan sempurna",
    ),
    "AchWinHard": MessageLookupByLibrary.simpleMessage("Menang mode Hard"),
    "AchWinStreak3": MessageLookupByLibrary.simpleMessage(
      "3 kemenangan beruntun",
    ),
    "AchWinStreak5": MessageLookupByLibrary.simpleMessage(
      "5 kemenangan beruntun",
    ),
    "AchievementUnlocked": MessageLookupByLibrary.simpleMessage(
      "Pencapaian terbuka",
    ),
    "Achievements": MessageLookupByLibrary.simpleMessage("Pencapaian"),
    "AdFailed": MessageLookupByLibrary.simpleMessage(
      "Iklan tidak tersedia. Coba lagi nanti.",
    ),
    "AdLoading": MessageLookupByLibrary.simpleMessage("Memuat iklan…"),
    "AdsRemoved": MessageLookupByLibrary.simpleMessage("Iklan telah dihapus"),
    "AgainstComputer": MessageLookupByLibrary.simpleMessage("Komputer"),
    "BestStreak": MessageLookupByLibrary.simpleMessage("Rekor terbaik"),
    "Black": MessageLookupByLibrary.simpleMessage("hitam"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("Hitam menang"),
    "BoardCell": m0,
    "BoardEmpty": MessageLookupByLibrary.simpleMessage("Kosong"),
    "BoardKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "Gunakan tombol panah untuk menjelajahi papan, lalu Enter atau Spasi untuk bermain di kotak bertanda.",
    ),
    "BoardLastMove": MessageLookupByLibrary.simpleMessage("Langkah terakhir"),
    "BoardLegalMove": MessageLookupByLibrary.simpleMessage("Langkah yang sah"),
    "BoardReviewKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "Gunakan tombol panah untuk menjelajahi papan.",
    ),
    "Cancel": MessageLookupByLibrary.simpleMessage("Batal"),
    "Classic_Reversi": MessageLookupByLibrary.simpleMessage("Classic Reversi"),
    "ComputerColor": m1,
    "ComputerThinking": MessageLookupByLibrary.simpleMessage(
      "Komputer sedang berpikir…",
    ),
    "ContinueGame": MessageLookupByLibrary.simpleMessage("Lanjutkan permainan"),
    "CurrentStreak": MessageLookupByLibrary.simpleMessage("Rekor kemenangan"),
    "DailyChallenge": MessageLookupByLibrary.simpleMessage("Tantangan Harian"),
    "DailyChallengeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Kalahkan teka-teki hari ini di Hard",
    ),
    "DailyCompleted": MessageLookupByLibrary.simpleMessage(
      "Selesai hari ini — main lagi untuk fun",
    ),
    "Difficulty": MessageLookupByLibrary.simpleMessage("Tingkat Kesulitan"),
    "DifficultyEasy": MessageLookupByLibrary.simpleMessage("Mudah"),
    "DifficultyHard": MessageLookupByLibrary.simpleMessage("Sulit"),
    "DifficultyMedium": MessageLookupByLibrary.simpleMessage("Sedang"),
    "DifficultySuperEasy": MessageLookupByLibrary.simpleMessage("Sangat Mudah"),
    "FeedbackBalanced": MessageLookupByLibrary.simpleMessage("Seimbang"),
    "FeedbackGentle": MessageLookupByLibrary.simpleMessage("Lembut"),
    "FeedbackIntensity": MessageLookupByLibrary.simpleMessage(
      "Intensitas umpan balik",
    ),
    "FeedbackLively": MessageLookupByLibrary.simpleMessage("Semarak"),
    "FirstPlayerComputer": MessageLookupByLibrary.simpleMessage("Komputer"),
    "FirstPlayerHuman": MessageLookupByLibrary.simpleMessage("Pemain"),
    "FirstPlayerRandom": MessageLookupByLibrary.simpleMessage("Acak"),
    "GameOver": MessageLookupByLibrary.simpleMessage("Permainan Selesai"),
    "GameSetup": MessageLookupByLibrary.simpleMessage("Atur permainan Anda"),
    "GameStatusAnnouncement": m2,
    "GamesPlayed": MessageLookupByLibrary.simpleMessage("Permainan dimainkan"),
    "GuidedFirstGame": MessageLookupByLibrary.simpleMessage(
      "Belajar dengan permainan terpandu",
    ),
    "GuidedFirstGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "Berlatih membalik keping, kuasai sudut, dan temukan ritme Anda.",
    ),
    "Haptics": MessageLookupByLibrary.simpleMessage("Getar"),
    "Help": MessageLookupByLibrary.simpleMessage("Bantuan"),
    "Hint": MessageLookupByLibrary.simpleMessage("Petunjuk"),
    "HintWithAd": MessageLookupByLibrary.simpleMessage(
      "Langkah yang sah · tonton iklan",
    ),
    "HintsEnabled": MessageLookupByLibrary.simpleMessage(
      "Petunjuk diaktifkan untuk permainan ini.",
    ),
    "Home": MessageLookupByLibrary.simpleMessage("Beranda"),
    "HomeTagline": MessageLookupByLibrary.simpleMessage(
      "Sedikit strategi. Waktu untuk diri sendiri.",
    ),
    "How_to_play": MessageLookupByLibrary.simpleMessage("Cara bermain?"),
    "How_to_play_explain": MessageLookupByLibrary.simpleMessage(
      "Dalam permainan ini, semua keping lawan yang berada dalam satu garis lurus dan diapit oleh keping yang baru diletakkan dan keping lain milik pemain saat ini akan dibalik menjadi warna pemain saat ini. Tujuan permainan adalah memiliki mayoritas keping dengan warna Anda saat kotak kosong terakhir yang bisa dimainkan terisi.",
    ),
    "KeepPlaying": MessageLookupByLibrary.simpleMessage("Terus bermain"),
    "More": MessageLookupByLibrary.simpleMessage("Lainnya"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("Aplikasi Lainnya"),
    "NewGame": MessageLookupByLibrary.simpleMessage("Permainan baru"),
    "OK": MessageLookupByLibrary.simpleMessage("OK"),
    "Opponent": MessageLookupByLibrary.simpleMessage("Lawan"),
    "PerfectWins": MessageLookupByLibrary.simpleMessage("Menang sempurna"),
    "Play": MessageLookupByLibrary.simpleMessage("Main"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage(
      "Main melawan teman di perangkat ini",
    ),
    "PlayerTurn": m3,
    "PrivacyOptions": MessageLookupByLibrary.simpleMessage("Opsi privasi"),
    "PrivacyOptionsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Perbarui pilihan privasi iklan Anda",
    ),
    "PrivacyPolicy": MessageLookupByLibrary.simpleMessage("Kebijakan Privasi"),
    "PrivacyPolicySubtitle": MessageLookupByLibrary.simpleMessage(
      "Cara kami menangani data dan iklan",
    ),
    "PurchaseAlreadyOwned": MessageLookupByLibrary.simpleMessage(
      "Anda sudah memiliki Hapus Iklan.",
    ),
    "PurchaseCancelled": MessageLookupByLibrary.simpleMessage(
      "Pembelian dibatalkan.",
    ),
    "PurchaseFailed": MessageLookupByLibrary.simpleMessage(
      "Pembelian gagal. Silakan coba lagi.",
    ),
    "PurchasePending": MessageLookupByLibrary.simpleMessage(
      "Pembelian menunggu persetujuan…",
    ),
    "PurchaseSuccess": MessageLookupByLibrary.simpleMessage(
      "Iklan telah dihapus. Terima kasih!",
    ),
    "PurchaseUnavailable": MessageLookupByLibrary.simpleMessage(
      "Pembelian saat ini tidak tersedia.",
    ),
    "ReduceMotion": MessageLookupByLibrary.simpleMessage("Kurangi gerakan"),
    "ReduceMotionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Meminimalkan gerakan keping dan efek perayaan",
    ),
    "Rematch": MessageLookupByLibrary.simpleMessage("Ulangi"),
    "RemoveAds": MessageLookupByLibrary.simpleMessage("Hapus Iklan"),
    "ReplaceSavedGameMessage": MessageLookupByLibrary.simpleMessage(
      "Permainan yang belum selesai akan diganti. Anda dapat melanjutkannya dari Beranda.",
    ),
    "ReplaceSavedGameTitle": MessageLookupByLibrary.simpleMessage(
      "Mulai permainan baru?",
    ),
    "RestartConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "Posisi papan saat ini akan diganti dengan posisi awal.",
    ),
    "RestartConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Ulangi permainan ini?",
    ),
    "RestartGame": MessageLookupByLibrary.simpleMessage(
      "Mulai ulang permainan",
    ),
    "RestoreNothing": MessageLookupByLibrary.simpleMessage(
      "Tidak ada pembelian untuk dipulihkan.",
    ),
    "RestorePurchases": MessageLookupByLibrary.simpleMessage(
      "Pulihkan Pembelian",
    ),
    "RestoreSuccess": MessageLookupByLibrary.simpleMessage(
      "Pembelian dipulihkan.",
    ),
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Papan tinjauan permainan",
    ),
    "ReviewCorners": m4,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("Posisi akhir"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("Ke awal"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("Tinjau permainan"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("Ke akhir"),
    "ReviewMove": m5,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("Langkah berikutnya"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage(
      "Langkah sebelumnya",
    ),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("Posisi awal"),
    "Rules": MessageLookupByLibrary.simpleMessage("Aturan"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "Papan Anda siap saat Anda ingin bermain.",
    ),
    "Settings": MessageLookupByLibrary.simpleMessage("Pengaturan"),
    "Share": MessageLookupByLibrary.simpleMessage("Bagikan"),
    "ShareResult": m6,
    "Sound": MessageLookupByLibrary.simpleMessage("Suara"),
    "StartGame": MessageLookupByLibrary.simpleMessage("Mulai Permainan"),
    "StartNewGame": MessageLookupByLibrary.simpleMessage(
      "Mulai permainan baru",
    ),
    "Stats": MessageLookupByLibrary.simpleMessage("Statistik"),
    "Theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "ThemeClassic": MessageLookupByLibrary.simpleMessage("Klasik"),
    "ThemeContrast": MessageLookupByLibrary.simpleMessage("Kontras"),
    "ThemeNight": MessageLookupByLibrary.simpleMessage("Malam"),
    "Tie": MessageLookupByLibrary.simpleMessage("Seri"),
    "Ties": MessageLookupByLibrary.simpleMessage("Seri"),
    "TurnPassed": m7,
    "TutorialBoardLabel": MessageLookupByLibrary.simpleMessage("Papan latihan"),
    "TutorialCaptureBody": MessageLookupByLibrary.simpleMessage(
      "Anda bermain sebagai Hitam. Ketuk kotak bertanda untuk mengapit keping putih di antara dua keping hitam.",
    ),
    "TutorialCaptureDoneBody": MessageLookupByLibrary.simpleMessage(
      "Keping putih yang diapit berubah menjadi hitam. Berikutnya Putih bermain, lalu giliran Anda lagi.",
    ),
    "TutorialCaptureDoneTitle": MessageLookupByLibrary.simpleMessage(
      "Begitulah cara membalik keping",
    ),
    "TutorialCaptureTitle": MessageLookupByLibrary.simpleMessage(
      "Balik keping pertama Anda",
    ),
    "TutorialCompleteBody": MessageLookupByLibrary.simpleMessage(
      "Menangkan permainan dengan memiliki lebih banyak keping di akhir. Jika tidak ada langkah yang sah, giliran Anda otomatis dilewati. Mulailah dari tingkat Mudah dan naikkan saat Anda merasa siap.",
    ),
    "TutorialCompleteTitle": MessageLookupByLibrary.simpleMessage(
      "Anda siap bermain",
    ),
    "TutorialCornersBody": MessageLookupByLibrary.simpleMessage(
      "Coba posisi latihan ini. Ketuk sudut bertanda di A1. Keping di sudut tidak dapat dibalik.",
    ),
    "TutorialCornersTitle": MessageLookupByLibrary.simpleMessage(
      "Kuasai sudut",
    ),
    "TutorialNext": MessageLookupByLibrary.simpleMessage("Lanjutkan"),
    "TutorialPlayEasy": MessageLookupByLibrary.simpleMessage(
      "Main di tingkat Mudah",
    ),
    "TutorialProgress": m8,
    "TutorialReplyBody": MessageLookupByLibrary.simpleMessage(
      "Putih sudah bermain. Ketuk kotak bertanda untuk membalik keping lagi.",
    ),
    "TutorialReplyDoneBody": MessageLookupByLibrary.simpleMessage(
      "Anda telah menyelesaikan satu giliran. Sekarang coba kuasai sudut di posisi latihan.",
    ),
    "TutorialSkip": MessageLookupByLibrary.simpleMessage("Lewati tutorial"),
    "TutorialTitle": MessageLookupByLibrary.simpleMessage(
      "Belajar sambil bermain",
    ),
    "TwoPlayersMode": MessageLookupByLibrary.simpleMessage(
      "2 Pemain (main bergantian)",
    ),
    "Undo": MessageLookupByLibrary.simpleMessage("Urungkan"),
    "UndoWithAd": MessageLookupByLibrary.simpleMessage(
      "Urungkan · tonton iklan",
    ),
    "Watch": MessageLookupByLibrary.simpleMessage("Tonton"),
    "WatchAd": MessageLookupByLibrary.simpleMessage("Tonton Iklan"),
    "WatchAdForHint": MessageLookupByLibrary.simpleMessage(
      "Tonton iklan singkat untuk menampilkan langkah legal.",
    ),
    "WatchAdForUndo": MessageLookupByLibrary.simpleMessage(
      "Tonton iklan singkat untuk membatalkan langkah terakhir.",
    ),
    "White": MessageLookupByLibrary.simpleMessage("putih"),
    "WhiteWins": MessageLookupByLibrary.simpleMessage("Putih menang"),
    "WhoGoesFirst": MessageLookupByLibrary.simpleMessage(
      "Siapa yang jalan duluan?",
    ),
    "WinRate": MessageLookupByLibrary.simpleMessage("Tingkat kemenangan"),
    "WinsByDifficulty": MessageLookupByLibrary.simpleMessage(
      "Menang per kesulitan",
    ),
    "WinsLosses": m9,
    "YouColor": m10,
    "YouLose": MessageLookupByLibrary.simpleMessage("Kamu kalah"),
    "YouWin": MessageLookupByLibrary.simpleMessage("Kamu menang!"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("Giliran Anda"),
  };
}
