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

  static String m0(coordinate, piece) => "${coordinate}, ${piece}";

  static String m1(color) => "Компьютер · ${color}";

  static String m2(status, black, white) =>
      "${status}. Чёрные ${black}, белые ${white}.";

  static String m3(color) => "Ход: ${color}";

  static String m4(black, white) => "Углы · Чёрные ${black} · Белые ${white}";

  static String m5(move, total) => "Ход ${move} из ${total}";

  static String m6(result, black, white, mode) =>
      "${result} · Чёрные ${black} – Белые ${white} (${mode}) — Classic Reversi";

  static String m7(passed, current) =>
      "${passed}: нет допустимых ходов. ${current} ходят снова.";

  static String m8(step, total) => "Урок ${step} из ${total}";

  static String m9(wins, losses) => "Побед ${wins} · Поражений ${losses}";

  static String m10(color) => "Вы · ${color}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "Accessibility": MessageLookupByLibrary.simpleMessage(
      "Специальные возможности",
    ),
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
    "AgainstComputer": MessageLookupByLibrary.simpleMessage("Компьютер"),
    "BestStreak": MessageLookupByLibrary.simpleMessage("Лучшая серия"),
    "Black": MessageLookupByLibrary.simpleMessage("чёрные"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("Чёрные побеждают"),
    "BoardCell": m0,
    "BoardEmpty": MessageLookupByLibrary.simpleMessage("Пусто"),
    "BoardKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "Перемещайтесь по доске клавишами со стрелками. Нажмите Enter или пробел, чтобы сделать ход в отмеченную клетку.",
    ),
    "BoardLastMove": MessageLookupByLibrary.simpleMessage("Последний ход"),
    "BoardLegalMove": MessageLookupByLibrary.simpleMessage("Допустимый ход"),
    "BoardReviewKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "Перемещайтесь по доске клавишами со стрелками.",
    ),
    "Cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "Classic_Reversi": MessageLookupByLibrary.simpleMessage(
      "Классические Реверси",
    ),
    "ComputerColor": m1,
    "ComputerThinking": MessageLookupByLibrary.simpleMessage(
      "Компьютер думает…",
    ),
    "ContinueGame": MessageLookupByLibrary.simpleMessage("Продолжить игру"),
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
    "DifficultySuperEasy": MessageLookupByLibrary.simpleMessage("Очень лёгкий"),
    "FeedbackBalanced": MessageLookupByLibrary.simpleMessage("Средняя"),
    "FeedbackGentle": MessageLookupByLibrary.simpleMessage("Слабая"),
    "FeedbackIntensity": MessageLookupByLibrary.simpleMessage(
      "Интенсивность отклика",
    ),
    "FeedbackLively": MessageLookupByLibrary.simpleMessage("Яркая"),
    "FirstPlayerComputer": MessageLookupByLibrary.simpleMessage("Компьютер"),
    "FirstPlayerHuman": MessageLookupByLibrary.simpleMessage("Игрок"),
    "FirstPlayerRandom": MessageLookupByLibrary.simpleMessage("Случайно"),
    "GameOver": MessageLookupByLibrary.simpleMessage("Игра окончена"),
    "GameSetup": MessageLookupByLibrary.simpleMessage("Настройте игру"),
    "GameStatusAnnouncement": m2,
    "GamesPlayed": MessageLookupByLibrary.simpleMessage("Сыграно партий"),
    "GuidedFirstGame": MessageLookupByLibrary.simpleMessage("Обучающая игра"),
    "GuidedFirstGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "Научитесь переворачивать фишки, занимать углы и находить свой ритм.",
    ),
    "Haptics": MessageLookupByLibrary.simpleMessage("Вибрация"),
    "Help": MessageLookupByLibrary.simpleMessage("Справка"),
    "Hint": MessageLookupByLibrary.simpleMessage("Подсказка"),
    "HintWithAd": MessageLookupByLibrary.simpleMessage(
      "Допустимые ходы · смотреть рекламу",
    ),
    "HintsEnabled": MessageLookupByLibrary.simpleMessage(
      "Подсказки включены для этой игры.",
    ),
    "Home": MessageLookupByLibrary.simpleMessage("Домой"),
    "HomeTagline": MessageLookupByLibrary.simpleMessage(
      "Немного стратегии. Мгновение для себя.",
    ),
    "How_to_play": MessageLookupByLibrary.simpleMessage("Как играть?"),
    "How_to_play_explain": MessageLookupByLibrary.simpleMessage(
      "В игре все фишки соперника, лежащие по прямой линии между только что поставленной фишкой и другой фишкой текущего игрока, переворачиваются в цвет текущего игрока. Цель игры — к моменту заполнения последней свободной клетки иметь на доске большинство фишек своего цвета.",
    ),
    "KeepPlaying": MessageLookupByLibrary.simpleMessage("Продолжить играть"),
    "More": MessageLookupByLibrary.simpleMessage("Ещё"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("Другие приложения"),
    "NewGame": MessageLookupByLibrary.simpleMessage("Новая игра"),
    "OK": MessageLookupByLibrary.simpleMessage("OK"),
    "Opponent": MessageLookupByLibrary.simpleMessage("Соперник"),
    "PerfectWins": MessageLookupByLibrary.simpleMessage("Идеальные победы"),
    "Play": MessageLookupByLibrary.simpleMessage("Играть"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage(
      "Играть с другом на этом устройстве",
    ),
    "PlayerTurn": m3,
    "PrivacyOptions": MessageLookupByLibrary.simpleMessage(
      "Параметры конфиденциальности",
    ),
    "PrivacyOptionsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Обновить настройки рекламной конфиденциальности",
    ),
    "PrivacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Политика конфиденциальности",
    ),
    "PrivacyPolicySubtitle": MessageLookupByLibrary.simpleMessage(
      "Как мы обрабатываем данные и рекламу",
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
    "ReduceMotion": MessageLookupByLibrary.simpleMessage("Уменьшить движение"),
    "ReduceMotionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Сводит к минимуму движение фишек и праздничные эффекты",
    ),
    "Rematch": MessageLookupByLibrary.simpleMessage("Ещё раз"),
    "RemoveAds": MessageLookupByLibrary.simpleMessage("Убрать рекламу"),
    "ReplaceSavedGameMessage": MessageLookupByLibrary.simpleMessage(
      "Незавершённая игра будет заменена. Вы можете продолжить её с главного экрана.",
    ),
    "ReplaceSavedGameTitle": MessageLookupByLibrary.simpleMessage(
      "Начать новую игру?",
    ),
    "RestartConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "Текущая позиция будет заменена начальной.",
    ),
    "RestartConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Начать эту игру заново?",
    ),
    "RestartGame": MessageLookupByLibrary.simpleMessage("Перезапустить игру"),
    "RestoreNothing": MessageLookupByLibrary.simpleMessage(
      "Нет покупок для восстановления.",
    ),
    "RestorePurchases": MessageLookupByLibrary.simpleMessage(
      "Восстановить покупки",
    ),
    "RestoreSuccess": MessageLookupByLibrary.simpleMessage(
      "Покупки восстановлены.",
    ),
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Доска разбора партии",
    ),
    "ReviewCorners": m4,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("Конечная позиция"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("К началу"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("Разбор партии"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("К концу"),
    "ReviewMove": m5,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("Следующий ход"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage("Предыдущий ход"),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("Начальная позиция"),
    "Rules": MessageLookupByLibrary.simpleMessage("Правила"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ваша доска ждёт вас.",
    ),
    "Settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "Share": MessageLookupByLibrary.simpleMessage("Поделиться"),
    "ShareResult": m6,
    "Sound": MessageLookupByLibrary.simpleMessage("Звук"),
    "StartGame": MessageLookupByLibrary.simpleMessage("Начать игру"),
    "StartNewGame": MessageLookupByLibrary.simpleMessage("Начать новую игру"),
    "Stats": MessageLookupByLibrary.simpleMessage("Статистика"),
    "Theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "ThemeClassic": MessageLookupByLibrary.simpleMessage("Классика"),
    "ThemeContrast": MessageLookupByLibrary.simpleMessage("Контраст"),
    "ThemeNight": MessageLookupByLibrary.simpleMessage("Ночь"),
    "Tie": MessageLookupByLibrary.simpleMessage("Ничья"),
    "Ties": MessageLookupByLibrary.simpleMessage("Ничьи"),
    "TurnPassed": m7,
    "TutorialBoardLabel": MessageLookupByLibrary.simpleMessage("Учебная доска"),
    "TutorialCaptureBody": MessageLookupByLibrary.simpleMessage(
      "Вы играете чёрными. Нажмите на отмеченную клетку, чтобы зажать белую фишку между двумя чёрными.",
    ),
    "TutorialCaptureDoneBody": MessageLookupByLibrary.simpleMessage(
      "Зажатая белая фишка становится чёрной. Теперь ходят белые, а затем снова вы.",
    ),
    "TutorialCaptureDoneTitle": MessageLookupByLibrary.simpleMessage(
      "Вот как переворачиваются фишки",
    ),
    "TutorialCaptureTitle": MessageLookupByLibrary.simpleMessage(
      "Переверните первые фишки",
    ),
    "TutorialCompleteBody": MessageLookupByLibrary.simpleMessage(
      "Побеждает тот, у кого в конце больше фишек. Если допустимых ходов нет, ход автоматически пропускается. Начните с лёгкого уровня и повышайте сложность, когда будете готовы.",
    ),
    "TutorialCompleteTitle": MessageLookupByLibrary.simpleMessage(
      "Всё готово к игре",
    ),
    "TutorialCornersBody": MessageLookupByLibrary.simpleMessage(
      "Попробуйте эту учебную позицию. Нажмите на отмеченный угол A1. Угловую фишку нельзя перевернуть.",
    ),
    "TutorialCornersTitle": MessageLookupByLibrary.simpleMessage(
      "Займите угол",
    ),
    "TutorialNext": MessageLookupByLibrary.simpleMessage("Продолжить"),
    "TutorialPlayEasy": MessageLookupByLibrary.simpleMessage(
      "Играть на лёгком уровне",
    ),
    "TutorialProgress": m8,
    "TutorialReplyBody": MessageLookupByLibrary.simpleMessage(
      "Белые сделали ход. Нажмите на любую отмеченную клетку, чтобы снова перевернуть фишки.",
    ),
    "TutorialReplyDoneBody": MessageLookupByLibrary.simpleMessage(
      "Вы прошли полный круг ходов. Теперь попробуйте занять угол в учебной позиции.",
    ),
    "TutorialSkip": MessageLookupByLibrary.simpleMessage("Пропустить обучение"),
    "TutorialTitle": MessageLookupByLibrary.simpleMessage("Учитесь играя"),
    "TwoPlayersMode": MessageLookupByLibrary.simpleMessage(
      "2 игрока (по очереди)",
    ),
    "Undo": MessageLookupByLibrary.simpleMessage("Отменить"),
    "UndoWithAd": MessageLookupByLibrary.simpleMessage(
      "Отменить ход · смотреть рекламу",
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
    "WinsLosses": m9,
    "YouColor": m10,
    "YouLose": MessageLookupByLibrary.simpleMessage("Вы проиграли"),
    "YouWin": MessageLookupByLibrary.simpleMessage("Вы победили!"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("Ваш ход"),
  };
}
