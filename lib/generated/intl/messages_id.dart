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

  static String m0(current, target) => "Permainan: ${current} dari ${target}";

  static String m1(current, target) =>
      "Kemenangan beruntun: ${current} dari ${target}";

  static String m2(current, target) => "Kemenangan: ${current} dari ${target}";

  static String m3(best, good, inaccuracies, mistakes) =>
      "Terbaik ${best} · Baik ${good} · Kurang tepat ${inaccuracies} · Kesalahan ${mistakes}";

  static String m4(move, played, suggested) =>
      "Langkah ${move}: memainkan ${played}, ${suggested} lebih kuat";

  static String m5(coordinate, piece) => "${coordinate}, ${piece}";

  static String m6(actual, suggested) =>
      "Dimainkan: ${actual} · Pelajari: ${suggested}";

  static String m7(player) => "Ide untuk ${player}";

  static String m8(coordinate) =>
      "Anda memainkan ${coordinate}. Tinjau kembali ide di baliknya.";

  static String m9(count) => "Balasan yang sah untuk lawan: ${count}.";

  static String m10(coordinate) => "Langkah yang disarankan: ${coordinate}";

  static String m11(count) =>
      "Anda telah memakai ${count} tip pelatih gratis hari ini. Tonton iklan singkat untuk satu tip lagi, atau jadi Premium untuk tip tanpa batas.";

  static String m12(count) =>
      "Kamu sudah memakai semua ${count} tip pelatih gratis hari ini. Jadi Premium untuk tip tanpa batas, atau kembali besok.";

  static String m13(coordinate) => "Tip pelatih: coba ${coordinate}.";

  static String m14(count) => "Tip pelatih · ${count} gratis hari ini";

  static String m15(color) => "Komputer · ${color}";

  static String m16(status, black, white) =>
      "${status}. Hitam ${black}, Putih ${white}.";

  static String m17(price) => "Dapatkan Premium · ${price}";

  static String m18(color) => "Giliran ${color}";

  static String m19(count) => "Keping yang dibalik: ${count}";

  static String m20(coordinate) => "Anda memainkan ${coordinate}";

  static String m21(store) =>
      "Sekali bayar. Tanpa langganan. Pulihkan kapan saja dengan akun ${store} Anda.";

  static String m22(theme) => "${theme} · Premium";

  static String m23(count) =>
      "Dapatkan langkah kuat beserta alasannya kapan saja. Pemain gratis mendapat ${count} tip per hari.";

  static String m24(color, coordinate) =>
      "Mainkan warna ${color}. Rebut sudut ${coordinate} dalam satu langkah.";

  static String m25(color) =>
      "Mainkan warna ${color}. Menangkan posisi akhir ini melawan balasan terbaik.";

  static String m26(number) => "Petunjuk ${number} dari 3";

  static String m27(coordinate) => "Coba ${coordinate}.";

  static String m28(number) => "Teka-teki ${number}";

  static String m29(color) =>
      "Mainkan warna ${color}. Paksa lawan melewatkan giliran agar Anda bermain lagi, tanpa mengakhiri permainan.";

  static String m30(completed, total) =>
      "${completed} dari ${total} terpecahkan";

  static String m31(store) =>
      "Sudah membeli? Pulihkan dari akun ${store} Anda.";

  static String m32(result, score, mode, date) =>
      "${result}. ${score}. ${mode}. ${date}.";

  static String m33(black, white) => "Sudut · Hitam ${black} · Putih ${white}";

  static String m34(move, total) => "Langkah ${move} dari ${total}";

  static String m35(black, white) => "Hitam ${black} · Putih ${white}";

  static String m36(result, black, white, mode) =>
      "${result} · Hitam ${black} – Putih ${white} (${mode}) — Classic Reversi";

  static String m37(passed, current) =>
      "${passed} tidak memiliki langkah yang sah. ${current} bermain lagi.";

  static String m38(step, total) => "Pelajaran ${step} dari ${total}";

  static String m39(wins, losses) => "Menang ${wins} · Kalah ${losses}";

  static String m40(color) => "Anda · ${color}";

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
    "AchievementGamesProgress": m0,
    "AchievementStreakProgress": m1,
    "AchievementUnlocked": MessageLookupByLibrary.simpleMessage(
      "Pencapaian terbuka",
    ),
    "AchievementWinsProgress": m2,
    "Achievements": MessageLookupByLibrary.simpleMessage("Pencapaian"),
    "AdFailed": MessageLookupByLibrary.simpleMessage(
      "Iklan tidak tersedia. Coba lagi nanti.",
    ),
    "AdLoading": MessageLookupByLibrary.simpleMessage("Memuat iklan…"),
    "AgainstComputer": MessageLookupByLibrary.simpleMessage("Komputer"),
    "AnalysisAccuracy": MessageLookupByLibrary.simpleMessage("akurasi"),
    "AnalysisClean": MessageLookupByLibrary.simpleMessage(
      "Tidak ada kesalahan berarti. Permainan yang bagus!",
    ),
    "AnalysisCounts": m3,
    "AnalysisInaccuracy": MessageLookupByLibrary.simpleMessage("Kurang tepat"),
    "AnalysisKeyMoments": MessageLookupByLibrary.simpleMessage("Momen penting"),
    "AnalysisLoading": MessageLookupByLibrary.simpleMessage(
      "Menganalisis setiap langkah…",
    ),
    "AnalysisLockedBody": MessageLookupByLibrary.simpleMessage(
      "Premium menilai akurasi Anda, menghitung seberapa sering Anda menemukan langkah pelatih, dan mencantumkan kesalahan penting untuk ditinjau.",
    ),
    "AnalysisMistake": MessageLookupByLibrary.simpleMessage("Kesalahan"),
    "AnalysisMoment": m4,
    "AnalysisNoMoves": MessageLookupByLibrary.simpleMessage(
      "Tidak ada keputusan untuk dianalisis dalam permainan ini.",
    ),
    "AnalysisTitle": MessageLookupByLibrary.simpleMessage("Analisis permainan"),
    "BestStreak": MessageLookupByLibrary.simpleMessage("Rekor terbaik"),
    "Black": MessageLookupByLibrary.simpleMessage("hitam"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("Hitam menang"),
    "BoardCell": m5,
    "BoardEmpty": MessageLookupByLibrary.simpleMessage("Kosong"),
    "BoardKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "Gunakan tombol panah untuk menjelajahi papan, lalu Enter atau Spasi untuk bermain di kotak bertanda.",
    ),
    "BoardLastMove": MessageLookupByLibrary.simpleMessage("Langkah terakhir"),
    "BoardLegalMove": MessageLookupByLibrary.simpleMessage("Langkah yang sah"),
    "BoardReviewKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "Gunakan tombol panah untuk menjelajahi papan.",
    ),
    "BoardSuggestedMove": MessageLookupByLibrary.simpleMessage(
      "Disarankan pelatih",
    ),
    "Cancel": MessageLookupByLibrary.simpleMessage("Batal"),
    "Classic_Reversi": MessageLookupByLibrary.simpleMessage("Classic Reversi"),
    "CoachAllowsCorner": MessageLookupByLibrary.simpleMessage(
      "Lawan dapat merebut sudut pada giliran berikutnya.",
    ),
    "CoachAnalyzing": MessageLookupByLibrary.simpleMessage(
      "Mencari posisi yang berguna untuk dipelajari…",
    ),
    "CoachAvoidCorner": MessageLookupByLibrary.simpleMessage(
      "Langkah sah lainnya memberi lawan kesempatan langsung merebut sudut. Langkah ini menghindari ancaman tersebut.",
    ),
    "CoachComparison": m6,
    "CoachCorner": MessageLookupByLibrary.simpleMessage(
      "Langkah ini merebut sudut. Keping di sudut tidak dapat dibalik.",
    ),
    "CoachEndsGame": MessageLookupByLibrary.simpleMessage(
      "Setelah langkah ini, kedua pihak tidak dapat bermain. Permainan berakhir.",
    ),
    "CoachForPlayer": m7,
    "CoachJump": MessageLookupByLibrary.simpleMessage("Buka posisi ini"),
    "CoachMatched": m8,
    "CoachNoPosition": MessageLookupByLibrary.simpleMessage(
      "Tidak ada posisi yang dapat dimainkan untuk dipelajari dalam permainan ini.",
    ),
    "CoachPass": MessageLookupByLibrary.simpleMessage(
      "Lawan tidak memiliki balasan yang sah, jadi Anda bermain lagi.",
    ),
    "CoachPositionTitle": MessageLookupByLibrary.simpleMessage(
      "Pelajari posisi ini",
    ),
    "CoachPractice": MessageLookupByLibrary.simpleMessage("Coba posisi ini"),
    "CoachReplies": m9,
    "CoachScope": MessageLookupByLibrary.simpleMessage(
      "Pencarian singkat memberikan ide untuk dipelajari, tetapi tidak menjamin langkah terkuat.",
    ),
    "CoachShareResult": MessageLookupByLibrary.simpleMessage("Bagikan hasil"),
    "CoachSuggested": m10,
    "CoachTip": MessageLookupByLibrary.simpleMessage("Tip pelatih"),
    "CoachTipLimitMessage": m11,
    "CoachTipLimitPremiumMessage": m12,
    "CoachTipLimitTitle": MessageLookupByLibrary.simpleMessage(
      "Tip gratis hari ini sudah habis",
    ),
    "CoachTipSuggestion": m13,
    "CoachTipWatchAd": MessageLookupByLibrary.simpleMessage("Tonton iklan"),
    "CoachTipWithAd": MessageLookupByLibrary.simpleMessage(
      "Tip pelatih · tonton iklan",
    ),
    "CoachTipWithPremium": MessageLookupByLibrary.simpleMessage(
      "Tip pelatih · Premium",
    ),
    "CoachTipsLeft": m14,
    "CoachTitle": MessageLookupByLibrary.simpleMessage("Pelatih strategi"),
    "CoachTurnTitle": MessageLookupByLibrary.simpleMessage(
      "Posisi yang layak ditinjau kembali",
    ),
    "CoachUnavailable": MessageLookupByLibrary.simpleMessage(
      "Analisis pelatih belum tersedia saat ini. Anda tetap dapat meninjau setiap langkah.",
    ),
    "ComputerColor": m15,
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
    "Delete": MessageLookupByLibrary.simpleMessage("Hapus"),
    "DeleteSavedMatch": MessageLookupByLibrary.simpleMessage("Hapus permainan"),
    "DeleteSavedMatchMessage": MessageLookupByLibrary.simpleMessage(
      "Rekaman ini akan dihapus dari arsip. Statistik Anda tidak akan berubah.",
    ),
    "DeleteSavedMatchTitle": MessageLookupByLibrary.simpleMessage(
      "Hapus permainan ini?",
    ),
    "Difficulty": MessageLookupByLibrary.simpleMessage("Tingkat Kesulitan"),
    "DifficultyEasy": MessageLookupByLibrary.simpleMessage("Mudah"),
    "DifficultyExpert": MessageLookupByLibrary.simpleMessage("Ahli"),
    "DifficultyHard": MessageLookupByLibrary.simpleMessage("Sulit"),
    "DifficultyMedium": MessageLookupByLibrary.simpleMessage("Sedang"),
    "DifficultySuperEasy": MessageLookupByLibrary.simpleMessage("Sangat Mudah"),
    "ExpertSetupNote": MessageLookupByLibrary.simpleMessage(
      "Ahli menghitung lebih dalam dan memainkan akhir permainan dengan sempurna. Mungkin perlu waktu sejenak untuk berpikir.",
    ),
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
    "GameSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Permainan Anda tidak dapat disimpan. Coba lagi sebelum keluar.",
    ),
    "GameSetup": MessageLookupByLibrary.simpleMessage("Atur permainan Anda"),
    "GameStatusAnnouncement": m16,
    "GamesPlayed": MessageLookupByLibrary.simpleMessage("Permainan dimainkan"),
    "GetPremium": MessageLookupByLibrary.simpleMessage("Dapatkan Premium"),
    "GetPremiumWithPrice": m17,
    "GoPremium": MessageLookupByLibrary.simpleMessage("Jadi Premium"),
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
    "HintWithPremium": MessageLookupByLibrary.simpleMessage(
      "Langkah yang sah · Premium",
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
    "MatchLibrary": MessageLookupByLibrary.simpleMessage("Arsip permainan"),
    "MatchLibraryDeleteError": MessageLookupByLibrary.simpleMessage(
      "Permainan ini tidak dapat dihapus. Silakan coba lagi.",
    ),
    "MatchLibraryEmptyBody": MessageLookupByLibrary.simpleMessage(
      "Selesaikan permainan dan permainan itu akan muncul di sini. Tinjau setiap langkah dan temukan ide baru untuk dicoba.",
    ),
    "MatchLibraryEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "Kisah Anda dimulai di sini",
    ),
    "MatchLibraryLoadError": MessageLookupByLibrary.simpleMessage(
      "Arsip permainan Anda tidak dapat dimuat.",
    ),
    "MatchLibraryOpen": MessageLookupByLibrary.simpleMessage(
      "Tinjau permainan",
    ),
    "MatchLibrarySaveError": MessageLookupByLibrary.simpleMessage(
      "Permainan ini tidak dapat disimpan ke arsip Anda.",
    ),
    "MatchLibrarySubtitle": MessageLookupByLibrary.simpleMessage(
      "100 permainan selesai terakhir Anda, siap ditinjau kembali.",
    ),
    "MilestoneCompleted": MessageLookupByLibrary.simpleMessage("Selesai"),
    "More": MessageLookupByLibrary.simpleMessage("Lainnya"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("Aplikasi Lainnya"),
    "NewGame": MessageLookupByLibrary.simpleMessage("Permainan baru"),
    "NextMilestone": MessageLookupByLibrary.simpleMessage("Target berikutnya"),
    "OK": MessageLookupByLibrary.simpleMessage("OK"),
    "Opponent": MessageLookupByLibrary.simpleMessage("Lawan"),
    "PerfectWins": MessageLookupByLibrary.simpleMessage("Menang sempurna"),
    "Play": MessageLookupByLibrary.simpleMessage("Main"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage(
      "Main melawan teman di perangkat ini",
    ),
    "PlayerTurn": m18,
    "PracticeBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Papan latihan strategi",
    ),
    "PracticeFlipped": m19,
    "PracticeInstructions": MessageLookupByLibrary.simpleMessage(
      "Mainkan salah satu kotak yang ditandai dan lihat perubahannya.",
    ),
    "PracticeNoMoves": MessageLookupByLibrary.simpleMessage(
      "Pihak ini tidak memiliki langkah yang sah dalam posisi ini.",
    ),
    "PracticePlayed": m20,
    "PracticeReset": MessageLookupByLibrary.simpleMessage("Coba langkah lain"),
    "PracticeSafe": MessageLookupByLibrary.simpleMessage(
      "Latihan terpisah dari permainan tersimpan dan statistik Anda.",
    ),
    "PracticeTitle": MessageLookupByLibrary.simpleMessage("Coba posisi ini"),
    "Premium": MessageLookupByLibrary.simpleMessage("Premium"),
    "PremiumActive": MessageLookupByLibrary.simpleMessage("Premium aktif"),
    "PremiumAdFreeBody": MessageLookupByLibrary.simpleMessage(
      "Tanpa iklan banner, iklan pembuka aplikasi, atau iklan berhadiah.",
    ),
    "PremiumAdFreeTitle": MessageLookupByLibrary.simpleMessage("Tanpa iklan"),
    "PremiumAnalysisBody": MessageLookupByLibrary.simpleMessage(
      "Skor akurasi dan kesalahan penting di setiap permainan, satu ketukan menuju posisinya.",
    ),
    "PremiumAnalysisTitle": MessageLookupByLibrary.simpleMessage(
      "Analisis permainan lengkap",
    ),
    "PremiumExpertBody": MessageLookupByLibrary.simpleMessage(
      "Tantang komputer terkuat dengan perhitungan lebih dalam dan akhir permainan yang sempurna.",
    ),
    "PremiumExpertTitle": MessageLookupByLibrary.simpleMessage("Lawan Ahli"),
    "PremiumHeadline": MessageLookupByLibrary.simpleMessage(
      "Tingkatkan ke Premium",
    ),
    "PremiumHintsBody": MessageLookupByLibrary.simpleMessage(
      "Lihat semua kotak yang sah di tingkat Sedang, Sulit, dan Ahli tanpa iklan.",
    ),
    "PremiumHintsBodyNoAds": MessageLookupByLibrary.simpleMessage(
      "Lihat semua kotak yang sah di tingkat Sedang, Sulit, dan Ahli.",
    ),
    "PremiumHintsTitle": MessageLookupByLibrary.simpleMessage(
      "Petunjuk langkah di mana saja",
    ),
    "PremiumIncludes": MessageLookupByLibrary.simpleMessage("Premium mencakup"),
    "PremiumOneTime": m21,
    "PremiumRequired": MessageLookupByLibrary.simpleMessage(
      "Memerlukan Premium",
    ),
    "PremiumSettingsActiveSubtitle": MessageLookupByLibrary.simpleMessage(
      "Terima kasih! Semua fitur Premium sudah terbuka.",
    ),
    "PremiumSettingsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tanpa iklan, urungkan dan tip tanpa batas, AI Ahli, dan lainnya",
    ),
    "PremiumSubheadline": MessageLookupByLibrary.simpleMessage(
      "Bermain tanpa iklan dan buka alat lanjutan untuk mempertajam setiap permainan.",
    ),
    "PremiumSubheadlineNoAds": MessageLookupByLibrary.simpleMessage(
      "Buka alat lanjutan untuk mempertajam setiap permainan.",
    ),
    "PremiumThemeLabel": m22,
    "PremiumThemesBody": MessageLookupByLibrary.simpleMessage(
      "Meja Royal dan Bara, khusus untuk Premium.",
    ),
    "PremiumThemesTitle": MessageLookupByLibrary.simpleMessage(
      "Tema papan eksklusif",
    ),
    "PremiumTipsBody": m23,
    "PremiumTipsTitle": MessageLookupByLibrary.simpleMessage(
      "Tip pelatih tanpa batas",
    ),
    "PremiumUndoBody": MessageLookupByLibrary.simpleMessage(
      "Batalkan langkah sebanyak yang Anda mau di semua tingkat kesulitan.",
    ),
    "PremiumUndoTitle": MessageLookupByLibrary.simpleMessage(
      "Urungkan tanpa batas",
    ),
    "PremiumWelcomeBody": MessageLookupByLibrary.simpleMessage(
      "Terima kasih atas dukungan Anda. Semua fitur Premium sudah terbuka.",
    ),
    "PremiumWelcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Anda pemain Premium",
    ),
    "PrivacyOptions": MessageLookupByLibrary.simpleMessage("Opsi privasi"),
    "PrivacyOptionsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Perbarui pilihan privasi iklan Anda",
    ),
    "PrivacyPolicy": MessageLookupByLibrary.simpleMessage("Kebijakan Privasi"),
    "PrivacyPolicySubtitle": MessageLookupByLibrary.simpleMessage(
      "Cara kami menangani data dan iklan",
    ),
    "PurchaseAlreadyOwned": MessageLookupByLibrary.simpleMessage(
      "Anda sudah memiliki Premium.",
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
      "Selamat datang di Premium! Semua fitur kini terbuka.",
    ),
    "PurchaseUnavailable": MessageLookupByLibrary.simpleMessage(
      "Pembelian saat ini tidak tersedia.",
    ),
    "PuzzleAllComplete": MessageLookupByLibrary.simpleMessage(
      "Semua sembilan teka-teki terpecahkan. Tinjau posisi mana pun untuk mempertajam permainan Anda.",
    ),
    "PuzzleBackToArchive": MessageLookupByLibrary.simpleMessage(
      "Kembali ke teka-teki",
    ),
    "PuzzleBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Papan teka-teki latihan",
    ),
    "PuzzleCompleted": MessageLookupByLibrary.simpleMessage("Terpecahkan"),
    "PuzzleCompletionSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Progres tidak dapat disimpan. Biarkan layar ini terbuka dan coba lagi.",
    ),
    "PuzzleCornerDescription": MessageLookupByLibrary.simpleMessage(
      "Temukan sudut yang aman dan tutup garis penangkapan.",
    ),
    "PuzzleCornerHintOne": MessageLookupByLibrary.simpleMessage(
      "Keping di sudut tidak dapat dibalik. Cari garis yang bisa Anda tutup.",
    ),
    "PuzzleCornerHintTwo": MessageLookupByLibrary.simpleMessage(
      "Telusuri dari sudut tujuan ke arah dalam hingga keping Anda mengapit deretan keping lawan.",
    ),
    "PuzzleCornerObjective": m24,
    "PuzzleCornerSkill": MessageLookupByLibrary.simpleMessage("Rebut sudut"),
    "PuzzleCornerSuccess": MessageLookupByLibrary.simpleMessage(
      "Sudut berhasil direbut. Keping sudut ini akan tetap menjadi milik Anda hingga permainan berakhir.",
    ),
    "PuzzleEndgameDescription": MessageLookupByLibrary.simpleMessage(
      "Mainkan langkah-langkah terakhir melawan balasan terbaik.",
    ),
    "PuzzleEndgameHintOne": MessageLookupByLibrary.simpleMessage(
      "Jumlah akhir keping menentukan pemenang. Hitung langkah hingga akhir.",
    ),
    "PuzzleEndgameHintTwo": MessageLookupByLibrary.simpleMessage(
      "Bandingkan balasan lawan. Menangkap lebih sedikit keping dapat menyisakan langkah terakhir untuk Anda.",
    ),
    "PuzzleEndgameObjective": m25,
    "PuzzleEndgameSkill": MessageLookupByLibrary.simpleMessage(
      "Akhiri dengan kemenangan",
    ),
    "PuzzleEndgameSuccess": MessageLookupByLibrary.simpleMessage(
      "Posisi akhir dimenangkan. Pilihan Anda mampu menghadapi balasan terbaik.",
    ),
    "PuzzleEndgameTryAgain": MessageLookupByLibrary.simpleMessage(
      "Jalur ini tidak dapat menjamin kemenangan melawan permainan terbaik. Mulai ulang dan bandingkan langkah lain.",
    ),
    "PuzzleHint": m26,
    "PuzzleHintCoordinate": m27,
    "PuzzleNext": MessageLookupByLibrary.simpleMessage("Teka-teki berikutnya"),
    "PuzzleNoResults": MessageLookupByLibrary.simpleMessage(
      "Tidak ada teka-teki yang cocok. Coba keterampilan atau nomor teka-teki.",
    ),
    "PuzzleNumber": m28,
    "PuzzleOpponentThinking": MessageLookupByLibrary.simpleMessage(
      "Mempertimbangkan balasan terbaik…",
    ),
    "PuzzlePassDescription": MessageLookupByLibrary.simpleMessage(
      "Buat lawan kehabisan langkah yang sah.",
    ),
    "PuzzlePassHintOne": MessageLookupByLibrary.simpleMessage(
      "Giliran hanya dilewatkan jika lawan tidak memiliki langkah yang sah.",
    ),
    "PuzzlePassHintTwo": MessageLookupByLibrary.simpleMessage(
      "Bandingkan langkah yang tersedia bagi lawan setelah setiap calon langkah Anda.",
    ),
    "PuzzlePassObjective": m29,
    "PuzzlePassSkill": MessageLookupByLibrary.simpleMessage(
      "Dapatkan giliran tambahan",
    ),
    "PuzzlePassSuccess": MessageLookupByLibrary.simpleMessage(
      "Anda mendapat giliran tambahan. Lawan tidak memiliki langkah yang sah dan permainan berlanjut.",
    ),
    "PuzzleProgress": m30,
    "PuzzleProgressLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Progres teka-teki tidak dapat dimuat. Coba lagi.",
    ),
    "PuzzleRestart": MessageLookupByLibrary.simpleMessage(
      "Mulai ulang teka-teki",
    ),
    "PuzzleRevealHint": MessageLookupByLibrary.simpleMessage(
      "Tampilkan petunjuk",
    ),
    "PuzzleSaveProgress": MessageLookupByLibrary.simpleMessage(
      "Simpan progres",
    ),
    "PuzzleSearch": MessageLookupByLibrary.simpleMessage("Cari teka-teki"),
    "PuzzleTryAgain": MessageLookupByLibrary.simpleMessage(
      "Langkah itu belum memecahkan posisi ini. Mulai ulang dan coba jalur lain.",
    ),
    "PuzzleYourMove": MessageLookupByLibrary.simpleMessage("Giliran Anda"),
    "Puzzles": MessageLookupByLibrary.simpleMessage("Teka-teki latihan"),
    "PuzzlesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Sembilan posisi yang dipilih dengan cermat. Asah satu keterampilan setiap kali.",
    ),
    "ReduceMotion": MessageLookupByLibrary.simpleMessage("Kurangi gerakan"),
    "ReduceMotionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Meminimalkan gerakan keping dan efek perayaan",
    ),
    "Rematch": MessageLookupByLibrary.simpleMessage("Ulangi"),
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
    "RestorePurchaseHelp": m31,
    "RestorePurchases": MessageLookupByLibrary.simpleMessage(
      "Pulihkan Pembelian",
    ),
    "RestoreSuccess": MessageLookupByLibrary.simpleMessage(
      "Pembelian dipulihkan.",
    ),
    "ResultCardError": MessageLookupByLibrary.simpleMessage(
      "Kartu hasil Anda tidak dapat dibuat.",
    ),
    "ResultCardPreparing": MessageLookupByLibrary.simpleMessage(
      "Membuat kartu hasil…",
    ),
    "ResultCardPreviewLabel": m32,
    "ResultCardShareFailed": MessageLookupByLibrary.simpleMessage(
      "Fitur berbagi belum tersedia saat ini. Silakan coba lagi.",
    ),
    "ResultCardTitle": MessageLookupByLibrary.simpleMessage(
      "Bagikan hasil Anda",
    ),
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Papan tinjauan permainan",
    ),
    "ReviewCorners": m33,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("Posisi akhir"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("Ke awal"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("Tinjau permainan"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("Ke akhir"),
    "ReviewMove": m34,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("Langkah berikutnya"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage(
      "Langkah sebelumnya",
    ),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("Posisi awal"),
    "Rules": MessageLookupByLibrary.simpleMessage("Aturan"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "Papan Anda siap saat Anda ingin bermain.",
    ),
    "SavedMatchScore": m35,
    "Settings": MessageLookupByLibrary.simpleMessage("Pengaturan"),
    "Share": MessageLookupByLibrary.simpleMessage("Bagikan"),
    "ShareResult": m36,
    "Sound": MessageLookupByLibrary.simpleMessage("Suara"),
    "StartGame": MessageLookupByLibrary.simpleMessage("Mulai Permainan"),
    "StartNewGame": MessageLookupByLibrary.simpleMessage(
      "Mulai permainan baru",
    ),
    "Stats": MessageLookupByLibrary.simpleMessage("Statistik"),
    "Theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "ThemeClassic": MessageLookupByLibrary.simpleMessage("Klasik"),
    "ThemeContrast": MessageLookupByLibrary.simpleMessage("Kontras"),
    "ThemeEmber": MessageLookupByLibrary.simpleMessage("Bara"),
    "ThemeNight": MessageLookupByLibrary.simpleMessage("Malam"),
    "ThemeRoyal": MessageLookupByLibrary.simpleMessage("Royal"),
    "Tie": MessageLookupByLibrary.simpleMessage("Seri"),
    "Ties": MessageLookupByLibrary.simpleMessage("Seri"),
    "TryAgain": MessageLookupByLibrary.simpleMessage("Coba lagi"),
    "TurnPassed": m37,
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
    "TutorialProgress": m38,
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
    "UndoUnlimited": MessageLookupByLibrary.simpleMessage(
      "Urungkan · tanpa batas",
    ),
    "UndoWithAd": MessageLookupByLibrary.simpleMessage(
      "Urungkan · tonton iklan",
    ),
    "UndoWithPremium": MessageLookupByLibrary.simpleMessage(
      "Urungkan · Premium",
    ),
    "UnlockWithPremium": MessageLookupByLibrary.simpleMessage(
      "Buka dengan Premium",
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
    "WinsLosses": m39,
    "YouColor": m40,
    "YouLose": MessageLookupByLibrary.simpleMessage("Kamu kalah"),
    "YouWin": MessageLookupByLibrary.simpleMessage("Kamu menang!"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("Giliran Anda"),
  };
}
