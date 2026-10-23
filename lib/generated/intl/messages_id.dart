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

  static String m3(coordinate, piece) => "${coordinate}, ${piece}";

  static String m4(actual, suggested) =>
      "Dimainkan: ${actual} · Pelajari: ${suggested}";

  static String m5(player) => "Ide untuk ${player}";

  static String m6(coordinate) =>
      "Anda memainkan ${coordinate}. Tinjau kembali ide di baliknya.";

  static String m7(count) => "Balasan yang sah untuk lawan: ${count}.";

  static String m8(coordinate) => "Langkah yang disarankan: ${coordinate}";

  static String m9(color) => "Komputer · ${color}";

  static String m10(status, black, white) =>
      "${status}. Hitam ${black}, Putih ${white}.";

  static String m11(color) => "Giliran ${color}";

  static String m12(count) => "Keping yang dibalik: ${count}";

  static String m13(coordinate) => "Anda memainkan ${coordinate}";

  static String m14(color, coordinate) =>
      "Mainkan warna ${color}. Rebut sudut ${coordinate} dalam satu langkah.";

  static String m15(color) =>
      "Mainkan warna ${color}. Menangkan posisi akhir ini melawan balasan terbaik.";

  static String m16(number) => "Petunjuk ${number} dari 3";

  static String m17(coordinate) => "Coba ${coordinate}.";

  static String m18(number) => "Teka-teki ${number}";

  static String m19(color) =>
      "Mainkan warna ${color}. Paksa lawan melewatkan giliran agar Anda bermain lagi, tanpa mengakhiri permainan.";

  static String m20(completed, total) =>
      "${completed} dari ${total} terpecahkan";

  static String m21(result, score, mode, date) =>
      "${result}. ${score}. ${mode}. ${date}.";

  static String m22(black, white) => "Sudut · Hitam ${black} · Putih ${white}";

  static String m23(move, total) => "Langkah ${move} dari ${total}";

  static String m24(black, white) => "Hitam ${black} · Putih ${white}";

  static String m25(result, black, white, mode) =>
      "${result} · Hitam ${black} – Putih ${white} (${mode}) — Classic Reversi";

  static String m26(passed, current) =>
      "${passed} tidak memiliki langkah yang sah. ${current} bermain lagi.";

  static String m27(step, total) => "Pelajaran ${step} dari ${total}";

  static String m28(wins, losses) => "Menang ${wins} · Kalah ${losses}";

  static String m29(color) => "Anda · ${color}";

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
    "AdsRemoved": MessageLookupByLibrary.simpleMessage("Iklan telah dihapus"),
    "AgainstComputer": MessageLookupByLibrary.simpleMessage("Komputer"),
    "BestStreak": MessageLookupByLibrary.simpleMessage("Rekor terbaik"),
    "Black": MessageLookupByLibrary.simpleMessage("hitam"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("Hitam menang"),
    "BoardCell": m3,
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
    "CoachAllowsCorner": MessageLookupByLibrary.simpleMessage(
      "Lawan dapat merebut sudut pada giliran berikutnya.",
    ),
    "CoachAnalyzing": MessageLookupByLibrary.simpleMessage(
      "Mencari posisi yang berguna untuk dipelajari…",
    ),
    "CoachAvoidCorner": MessageLookupByLibrary.simpleMessage(
      "Langkah sah lainnya memberi lawan kesempatan langsung merebut sudut. Langkah ini menghindari ancaman tersebut.",
    ),
    "CoachComparison": m4,
    "CoachCorner": MessageLookupByLibrary.simpleMessage(
      "Langkah ini merebut sudut. Keping di sudut tidak dapat dibalik.",
    ),
    "CoachEndsGame": MessageLookupByLibrary.simpleMessage(
      "Setelah langkah ini, kedua pihak tidak dapat bermain. Permainan berakhir.",
    ),
    "CoachForPlayer": m5,
    "CoachJump": MessageLookupByLibrary.simpleMessage("Buka posisi ini"),
    "CoachMatched": m6,
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
    "CoachReplies": m7,
    "CoachScope": MessageLookupByLibrary.simpleMessage(
      "Pencarian singkat memberikan ide untuk dipelajari, tetapi tidak menjamin langkah terkuat.",
    ),
    "CoachShareResult": MessageLookupByLibrary.simpleMessage("Bagikan hasil"),
    "CoachSuggested": m8,
    "CoachTitle": MessageLookupByLibrary.simpleMessage("Pelatih strategi"),
    "CoachTurnTitle": MessageLookupByLibrary.simpleMessage(
      "Posisi yang layak ditinjau kembali",
    ),
    "CoachUnavailable": MessageLookupByLibrary.simpleMessage(
      "Analisis pelatih belum tersedia saat ini. Anda tetap dapat meninjau setiap langkah.",
    ),
    "ComputerColor": m9,
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
    "GameSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Permainan Anda tidak dapat disimpan. Coba lagi sebelum keluar.",
    ),
    "GameSetup": MessageLookupByLibrary.simpleMessage("Atur permainan Anda"),
    "GameStatusAnnouncement": m10,
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
    "PlayerTurn": m11,
    "PracticeBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Papan latihan strategi",
    ),
    "PracticeFlipped": m12,
    "PracticeInstructions": MessageLookupByLibrary.simpleMessage(
      "Mainkan salah satu kotak yang ditandai dan lihat perubahannya.",
    ),
    "PracticeNoMoves": MessageLookupByLibrary.simpleMessage(
      "Pihak ini tidak memiliki langkah yang sah dalam posisi ini.",
    ),
    "PracticePlayed": m13,
    "PracticeReset": MessageLookupByLibrary.simpleMessage("Coba langkah lain"),
    "PracticeSafe": MessageLookupByLibrary.simpleMessage(
      "Latihan terpisah dari permainan tersimpan dan statistik Anda.",
    ),
    "PracticeTitle": MessageLookupByLibrary.simpleMessage("Coba posisi ini"),
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
    "PurchaseBenefitAds": MessageLookupByLibrary.simpleMessage(
      "Tanpa iklan banner atau iklan saat kembali ke aplikasi.",
    ),
    "PurchaseBenefitHints": MessageLookupByLibrary.simpleMessage(
      "Petunjuk langkah yang sah pada semua tingkat lawan komputer tanpa menonton iklan.",
    ),
    "PurchaseBenefitOnce": MessageLookupByLibrary.simpleMessage(
      "Sekali bayar. Tanpa langganan. Pulihkan dengan akun App Store Anda.",
    ),
    "PurchaseBenefitUndo": MessageLookupByLibrary.simpleMessage(
      "Batalkan langkah sekali per giliran pada tingkat Sulit tanpa menonton iklan.",
    ),
    "PurchaseBenefits": MessageLookupByLibrary.simpleMessage(
      "Pembelian satu kali menghapus iklan banner dan iklan saat kembali ke aplikasi, serta membuka pembatalan langkah pada tingkat Sulit dan petunjuk langkah yang sah tanpa iklan berhadiah. Pulihkan di perangkat yang memakai akun App Store yang sama.",
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
    "PuzzleCornerObjective": m14,
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
    "PuzzleEndgameObjective": m15,
    "PuzzleEndgameSkill": MessageLookupByLibrary.simpleMessage(
      "Akhiri dengan kemenangan",
    ),
    "PuzzleEndgameSuccess": MessageLookupByLibrary.simpleMessage(
      "Posisi akhir dimenangkan. Pilihan Anda mampu menghadapi balasan terbaik.",
    ),
    "PuzzleEndgameTryAgain": MessageLookupByLibrary.simpleMessage(
      "Jalur ini tidak dapat menjamin kemenangan melawan permainan terbaik. Mulai ulang dan bandingkan langkah lain.",
    ),
    "PuzzleHint": m16,
    "PuzzleHintCoordinate": m17,
    "PuzzleNext": MessageLookupByLibrary.simpleMessage("Teka-teki berikutnya"),
    "PuzzleNoResults": MessageLookupByLibrary.simpleMessage(
      "Tidak ada teka-teki yang cocok. Coba keterampilan atau nomor teka-teki.",
    ),
    "PuzzleNumber": m18,
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
    "PuzzlePassObjective": m19,
    "PuzzlePassSkill": MessageLookupByLibrary.simpleMessage(
      "Dapatkan giliran tambahan",
    ),
    "PuzzlePassSuccess": MessageLookupByLibrary.simpleMessage(
      "Anda mendapat giliran tambahan. Lawan tidak memiliki langkah yang sah dan permainan berlanjut.",
    ),
    "PuzzleProgress": m20,
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
    "ResultCardError": MessageLookupByLibrary.simpleMessage(
      "Kartu hasil Anda tidak dapat dibuat.",
    ),
    "ResultCardPreparing": MessageLookupByLibrary.simpleMessage(
      "Membuat kartu hasil…",
    ),
    "ResultCardPreviewLabel": m21,
    "ResultCardShareFailed": MessageLookupByLibrary.simpleMessage(
      "Fitur berbagi belum tersedia saat ini. Silakan coba lagi.",
    ),
    "ResultCardTitle": MessageLookupByLibrary.simpleMessage(
      "Bagikan hasil Anda",
    ),
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Papan tinjauan permainan",
    ),
    "ReviewCorners": m22,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("Posisi akhir"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("Ke awal"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("Tinjau permainan"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("Ke akhir"),
    "ReviewMove": m23,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("Langkah berikutnya"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage(
      "Langkah sebelumnya",
    ),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("Posisi awal"),
    "Rules": MessageLookupByLibrary.simpleMessage("Aturan"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "Papan Anda siap saat Anda ingin bermain.",
    ),
    "SavedMatchScore": m24,
    "Settings": MessageLookupByLibrary.simpleMessage("Pengaturan"),
    "Share": MessageLookupByLibrary.simpleMessage("Bagikan"),
    "ShareResult": m25,
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
    "TryAgain": MessageLookupByLibrary.simpleMessage("Coba lagi"),
    "TurnPassed": m26,
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
    "TutorialProgress": m27,
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
    "WinsLosses": m28,
    "YouColor": m29,
    "YouLose": MessageLookupByLibrary.simpleMessage("Kamu kalah"),
    "YouWin": MessageLookupByLibrary.simpleMessage("Kamu menang!"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("Giliran Anda"),
  };
}
