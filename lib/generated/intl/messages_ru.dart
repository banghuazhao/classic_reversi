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

  static String m0(current, target) => "Партий: ${current} из ${target}";

  static String m1(current, target) => "Побед подряд: ${current} из ${target}";

  static String m2(current, target) => "Побед: ${current} из ${target}";

  static String m3(coordinate, piece) => "${coordinate}, ${piece}";

  static String m4(actual, suggested) =>
      "В партии: ${actual} · Для разбора: ${suggested}";

  static String m5(player) => "Идеи для игрока ${player}";

  static String m6(coordinate) =>
      "Вы сыграли ${coordinate}. Вернитесь к идеям этого хода.";

  static String m7(count) => "Допустимых ответов соперника: ${count}.";

  static String m8(coordinate) => "Предлагаемый ход: ${coordinate}";

  static String m9(color) => "Компьютер · ${color}";

  static String m10(status, black, white) =>
      "${status}. Чёрные ${black}, белые ${white}.";

  static String m11(color) => "Ход: ${color}";

  static String m12(count) => "Перевёрнуто фишек: ${count}";

  static String m13(coordinate) => "Ваш ход: ${coordinate}";

  static String m14(color, coordinate) =>
      "Играйте цветом ${color}. Займите угол ${coordinate} за один ход.";

  static String m15(color) =>
      "Играйте цветом ${color}. Выиграйте этот эндшпиль против лучших ответов соперника.";

  static String m16(number) => "Подсказка ${number} из 3";

  static String m17(coordinate) => "Попробуйте ${coordinate}.";

  static String m18(number) => "Задача ${number}";

  static String m19(color) =>
      "Играйте цветом ${color}. Вынудите соперника пропустить ход, чтобы походить снова, не заканчивая партию.";

  static String m20(completed, total) => "Решено: ${completed} из ${total}";

  static String m21(result, score, mode, date) =>
      "${result}. ${score}. ${mode}. ${date}.";

  static String m22(black, white) => "Углы · Чёрные ${black} · Белые ${white}";

  static String m23(move, total) => "Ход ${move} из ${total}";

  static String m24(black, white) => "Чёрные ${black} · Белые ${white}";

  static String m25(result, black, white, mode) =>
      "${result} · Чёрные ${black} – Белые ${white} (${mode}) — Classic Reversi";

  static String m26(passed, current) =>
      "${passed}: нет допустимых ходов. ${current} ходят снова.";

  static String m27(step, total) => "Урок ${step} из ${total}";

  static String m28(wins, losses) => "Побед ${wins} · Поражений ${losses}";

  static String m29(color) => "Вы · ${color}";

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
    "AchievementGamesProgress": m0,
    "AchievementStreakProgress": m1,
    "AchievementUnlocked": MessageLookupByLibrary.simpleMessage(
      "Достижение открыто",
    ),
    "AchievementWinsProgress": m2,
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
    "BoardCell": m3,
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
    "CoachAllowsCorner": MessageLookupByLibrary.simpleMessage(
      "На следующем ходу соперник может занять угол.",
    ),
    "CoachAnalyzing": MessageLookupByLibrary.simpleMessage(
      "Ищем интересную позицию для разбора…",
    ),
    "CoachAvoidCorner": MessageLookupByLibrary.simpleMessage(
      "Другой допустимый ход сразу отдаёт сопернику угол. Этот ход позволяет избежать угрозы.",
    ),
    "CoachComparison": m4,
    "CoachCorner": MessageLookupByLibrary.simpleMessage(
      "Этот ход занимает угол. Угловую фишку невозможно перевернуть.",
    ),
    "CoachEndsGame": MessageLookupByLibrary.simpleMessage(
      "После этого хода ни одна сторона не может ходить. Партия заканчивается.",
    ),
    "CoachForPlayer": m5,
    "CoachJump": MessageLookupByLibrary.simpleMessage("Перейти к этой позиции"),
    "CoachMatched": m6,
    "CoachNoPosition": MessageLookupByLibrary.simpleMessage(
      "В этой партии нет позиций с доступными ходами для разбора.",
    ),
    "CoachPass": MessageLookupByLibrary.simpleMessage(
      "У соперника нет допустимого ответа, поэтому вы ходите снова.",
    ),
    "CoachPositionTitle": MessageLookupByLibrary.simpleMessage(
      "Разберите эту позицию",
    ),
    "CoachPractice": MessageLookupByLibrary.simpleMessage(
      "Попробовать эту позицию",
    ),
    "CoachReplies": m7,
    "CoachScope": MessageLookupByLibrary.simpleMessage(
      "Неглубокий поиск предлагает идеи для разбора, но не гарантирует самый сильный ход.",
    ),
    "CoachShareResult": MessageLookupByLibrary.simpleMessage(
      "Поделиться результатом",
    ),
    "CoachSuggested": m8,
    "CoachTitle": MessageLookupByLibrary.simpleMessage("Тренер по стратегии"),
    "CoachTurnTitle": MessageLookupByLibrary.simpleMessage(
      "Позиция, к которой стоит вернуться",
    ),
    "CoachUnavailable": MessageLookupByLibrary.simpleMessage(
      "Сейчас разбор недоступен. Вы по-прежнему можете просмотреть все ходы.",
    ),
    "ComputerColor": m9,
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
    "Delete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "DeleteSavedMatch": MessageLookupByLibrary.simpleMessage("Удалить партию"),
    "DeleteSavedMatchMessage": MessageLookupByLibrary.simpleMessage(
      "Эта запись будет удалена из архива. Ваша статистика не изменится.",
    ),
    "DeleteSavedMatchTitle": MessageLookupByLibrary.simpleMessage(
      "Удалить эту партию?",
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
    "GameStatusAnnouncement": m10,
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
    "MatchLibrary": MessageLookupByLibrary.simpleMessage("Архив партий"),
    "MatchLibraryDeleteError": MessageLookupByLibrary.simpleMessage(
      "Не удалось удалить партию. Попробуйте ещё раз.",
    ),
    "MatchLibraryEmptyBody": MessageLookupByLibrary.simpleMessage(
      "Завершите партию, и она появится здесь. Просматривайте ходы и находите новые идеи для игры.",
    ),
    "MatchLibraryEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "Ваша история начинается здесь",
    ),
    "MatchLibraryLoadError": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить архив партий.",
    ),
    "MatchLibraryOpen": MessageLookupByLibrary.simpleMessage(
      "Просмотреть партию",
    ),
    "MatchLibrarySaveError": MessageLookupByLibrary.simpleMessage(
      "Не удалось сохранить эту партию в архив.",
    ),
    "MatchLibrarySubtitle": MessageLookupByLibrary.simpleMessage(
      "Ваши последние 100 завершённых партий для просмотра по ходам.",
    ),
    "MilestoneCompleted": MessageLookupByLibrary.simpleMessage("Выполнено"),
    "More": MessageLookupByLibrary.simpleMessage("Ещё"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("Другие приложения"),
    "NewGame": MessageLookupByLibrary.simpleMessage("Новая игра"),
    "NextMilestone": MessageLookupByLibrary.simpleMessage("Следующая цель"),
    "OK": MessageLookupByLibrary.simpleMessage("OK"),
    "Opponent": MessageLookupByLibrary.simpleMessage("Соперник"),
    "PerfectWins": MessageLookupByLibrary.simpleMessage("Идеальные победы"),
    "Play": MessageLookupByLibrary.simpleMessage("Играть"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage(
      "Играть с другом на этом устройстве",
    ),
    "PlayerTurn": m11,
    "PracticeBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Доска для тренировки стратегии",
    ),
    "PracticeFlipped": m12,
    "PracticeInstructions": MessageLookupByLibrary.simpleMessage(
      "Сыграйте в любую отмеченную клетку и изучите изменения.",
    ),
    "PracticeNoMoves": MessageLookupByLibrary.simpleMessage(
      "У этой стороны нет допустимых ходов в данной позиции.",
    ),
    "PracticePlayed": m13,
    "PracticeReset": MessageLookupByLibrary.simpleMessage(
      "Попробовать другой ход",
    ),
    "PracticeSafe": MessageLookupByLibrary.simpleMessage(
      "Тренировка не влияет на сохранённую партию и статистику.",
    ),
    "PracticeTitle": MessageLookupByLibrary.simpleMessage(
      "Попробуйте эту позицию",
    ),
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
    "PurchaseBenefitAds": MessageLookupByLibrary.simpleMessage(
      "Без баннеров и рекламы при возвращении в приложение.",
    ),
    "PurchaseBenefitHints": MessageLookupByLibrary.simpleMessage(
      "Подсказки допустимых ходов на любом уровне игры с компьютером без просмотра рекламы.",
    ),
    "PurchaseBenefitOnce": MessageLookupByLibrary.simpleMessage(
      "Один платёж. Без подписки. Восстановление через вашу учётную запись App Store.",
    ),
    "PurchaseBenefitUndo": MessageLookupByLibrary.simpleMessage(
      "Одна отмена хода за свой ход на сложном уровне без просмотра рекламы.",
    ),
    "PurchaseBenefits": MessageLookupByLibrary.simpleMessage(
      "Разовая покупка убирает баннеры и рекламу при возвращении в приложение, а также открывает отмену хода на сложном уровне и подсказки допустимых ходов без рекламы за награду. Покупку можно восстановить на устройствах с той же учётной записью App Store.",
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
    "PuzzleAllComplete": MessageLookupByLibrary.simpleMessage(
      "Все девять задач решены. Возвращайтесь к любой позиции, чтобы отточить игру.",
    ),
    "PuzzleBackToArchive": MessageLookupByLibrary.simpleMessage(
      "К списку задач",
    ),
    "PuzzleBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Доска тренировочной задачи",
    ),
    "PuzzleCompleted": MessageLookupByLibrary.simpleMessage("Решено"),
    "PuzzleCompletionSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось сохранить прогресс. Оставьте этот экран открытым и попробуйте ещё раз.",
    ),
    "PuzzleCornerDescription": MessageLookupByLibrary.simpleMessage(
      "Найдите безопасный угол и замкните линию захвата.",
    ),
    "PuzzleCornerHintOne": MessageLookupByLibrary.simpleMessage(
      "Угловые фишки нельзя перевернуть. Найдите линию, которую можно замкнуть.",
    ),
    "PuzzleCornerHintTwo": MessageLookupByLibrary.simpleMessage(
      "Проследите линию от нужного угла к центру: ваша фишка должна замкнуть ряд фишек соперника.",
    ),
    "PuzzleCornerObjective": m14,
    "PuzzleCornerSkill": MessageLookupByLibrary.simpleMessage("Займите угол"),
    "PuzzleCornerSuccess": MessageLookupByLibrary.simpleMessage(
      "Угол занят. Эта фишка останется вашей до конца партии.",
    ),
    "PuzzleEndgameDescription": MessageLookupByLibrary.simpleMessage(
      "Сыграйте последние ходы против лучших ответов соперника.",
    ),
    "PuzzleEndgameHintOne": MessageLookupByLibrary.simpleMessage(
      "Победителя определяет итоговое число фишек. Просчитайте партию до конца.",
    ),
    "PuzzleEndgameHintTwo": MessageLookupByLibrary.simpleMessage(
      "Сравните ответы соперника. Захват меньшего числа фишек может сохранить за вами последний ход.",
    ),
    "PuzzleEndgameObjective": m15,
    "PuzzleEndgameSkill": MessageLookupByLibrary.simpleMessage(
      "Завершите победой",
    ),
    "PuzzleEndgameSuccess": MessageLookupByLibrary.simpleMessage(
      "Эндшпиль выигран. Ваши решения устояли против лучших ответов соперника.",
    ),
    "PuzzleEndgameTryAgain": MessageLookupByLibrary.simpleMessage(
      "Эта линия не гарантирует победу против лучшей игры. Начните заново и сравните другой ход.",
    ),
    "PuzzleHint": m16,
    "PuzzleHintCoordinate": m17,
    "PuzzleNext": MessageLookupByLibrary.simpleMessage("Следующая задача"),
    "PuzzleNoResults": MessageLookupByLibrary.simpleMessage(
      "Подходящих задач нет. Попробуйте название навыка или номер задачи.",
    ),
    "PuzzleNumber": m18,
    "PuzzleOpponentThinking": MessageLookupByLibrary.simpleMessage(
      "Ищем лучший ответ…",
    ),
    "PuzzlePassDescription": MessageLookupByLibrary.simpleMessage(
      "Лишите соперника допустимых ходов.",
    ),
    "PuzzlePassHintOne": MessageLookupByLibrary.simpleMessage(
      "Пропуск хода происходит только тогда, когда у соперника нет допустимых ходов.",
    ),
    "PuzzlePassHintTwo": MessageLookupByLibrary.simpleMessage(
      "Сравните доступные ходы соперника после каждого вашего возможного хода.",
    ),
    "PuzzlePassObjective": m19,
    "PuzzlePassSkill": MessageLookupByLibrary.simpleMessage(
      "Получите ещё один ход",
    ),
    "PuzzlePassSuccess": MessageLookupByLibrary.simpleMessage(
      "Вы получили ещё один ход. У соперника нет допустимого хода, и партия продолжается.",
    ),
    "PuzzleProgress": m20,
    "PuzzleRestart": MessageLookupByLibrary.simpleMessage(
      "Начать задачу заново",
    ),
    "PuzzleRevealHint": MessageLookupByLibrary.simpleMessage(
      "Показать подсказку",
    ),
    "PuzzleSaveProgress": MessageLookupByLibrary.simpleMessage(
      "Сохранить прогресс",
    ),
    "PuzzleSearch": MessageLookupByLibrary.simpleMessage("Поиск задач"),
    "PuzzleTryAgain": MessageLookupByLibrary.simpleMessage(
      "Этот ход не решает задачу. Начните заново и попробуйте другую линию.",
    ),
    "PuzzleYourMove": MessageLookupByLibrary.simpleMessage("Ваш ход"),
    "Puzzles": MessageLookupByLibrary.simpleMessage("Тренировочные задачи"),
    "PuzzlesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Девять тщательно подобранных позиций. Развивайте навыки шаг за шагом.",
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
    "ResultCardError": MessageLookupByLibrary.simpleMessage(
      "Не удалось создать карточку результата.",
    ),
    "ResultCardPreparing": MessageLookupByLibrary.simpleMessage(
      "Создаём карточку результата…",
    ),
    "ResultCardPreviewLabel": m21,
    "ResultCardShareFailed": MessageLookupByLibrary.simpleMessage(
      "Сейчас не удаётся поделиться. Попробуйте ещё раз.",
    ),
    "ResultCardTitle": MessageLookupByLibrary.simpleMessage(
      "Поделиться результатом",
    ),
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Доска разбора партии",
    ),
    "ReviewCorners": m22,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("Конечная позиция"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("К началу"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("Разбор партии"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("К концу"),
    "ReviewMove": m23,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("Следующий ход"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage("Предыдущий ход"),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("Начальная позиция"),
    "Rules": MessageLookupByLibrary.simpleMessage("Правила"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ваша доска ждёт вас.",
    ),
    "SavedMatchScore": m24,
    "Settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "Share": MessageLookupByLibrary.simpleMessage("Поделиться"),
    "ShareResult": m25,
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
    "TryAgain": MessageLookupByLibrary.simpleMessage("Попробовать ещё раз"),
    "TurnPassed": m26,
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
    "TutorialProgress": m27,
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
    "WinsLosses": m28,
    "YouColor": m29,
    "YouLose": MessageLookupByLibrary.simpleMessage("Вы проиграли"),
    "YouWin": MessageLookupByLibrary.simpleMessage("Вы победили!"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("Ваш ход"),
  };
}
