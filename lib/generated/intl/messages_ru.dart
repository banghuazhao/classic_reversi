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

  static String m3(best, good, inaccuracies, mistakes) =>
      "Лучшие ${best} · Хорошие ${good} · Неточности ${inaccuracies} · Ошибки ${mistakes}";

  static String m4(move, played, suggested) =>
      "Ход ${move}: сыграно ${played}, сильнее было ${suggested}";

  static String m5(coordinate, piece) => "${coordinate}, ${piece}";

  static String m6(actual, suggested) =>
      "В партии: ${actual} · Для разбора: ${suggested}";

  static String m7(player) => "Идеи для игрока ${player}";

  static String m8(coordinate) =>
      "Вы сыграли ${coordinate}. Вернитесь к идеям этого хода.";

  static String m9(count) => "Допустимых ответов соперника: ${count}.";

  static String m10(coordinate) => "Предлагаемый ход: ${coordinate}";

  static String m11(count) =>
      "Вы использовали все ${count} бесплатных совета на сегодня. Посмотрите короткую рекламу, чтобы получить ещё один, или перейдите на Премиум для безлимитных советов.";

  static String m12(coordinate) => "Совет тренера: попробуйте ${coordinate}.";

  static String m13(count) => "Совет тренера · бесплатно сегодня: ${count}";

  static String m14(color) => "Компьютер · ${color}";

  static String m15(status, black, white) =>
      "${status}. Чёрные ${black}, белые ${white}.";

  static String m16(price) => "Получить Премиум · ${price}";

  static String m17(color) => "Ход: ${color}";

  static String m18(count) => "Перевёрнуто фишек: ${count}";

  static String m19(coordinate) => "Ваш ход: ${coordinate}";

  static String m20(store) =>
      "Один платёж, без подписки. Восстановить покупку можно в любой момент через аккаунт ${store}.";

  static String m21(theme) => "${theme} · Премиум";

  static String m22(count) =>
      "Узнавайте сильный ход и его смысл в любой момент. Без Премиум — ${count} совета в день.";

  static String m23(color, coordinate) =>
      "Играйте цветом ${color}. Займите угол ${coordinate} за один ход.";

  static String m24(color) =>
      "Играйте цветом ${color}. Выиграйте этот эндшпиль против лучших ответов соперника.";

  static String m25(number) => "Подсказка ${number} из 3";

  static String m26(coordinate) => "Попробуйте ${coordinate}.";

  static String m27(number) => "Задача ${number}";

  static String m28(color) =>
      "Играйте цветом ${color}. Вынудите соперника пропустить ход, чтобы походить снова, не заканчивая партию.";

  static String m29(completed, total) => "Решено: ${completed} из ${total}";

  static String m30(store) =>
      "Уже купили? Восстановите покупку из аккаунта ${store}.";

  static String m31(result, score, mode, date) =>
      "${result}. ${score}. ${mode}. ${date}.";

  static String m32(black, white) => "Углы · Чёрные ${black} · Белые ${white}";

  static String m33(move, total) => "Ход ${move} из ${total}";

  static String m34(black, white) => "Чёрные ${black} · Белые ${white}";

  static String m35(result, black, white, mode) =>
      "${result} · Чёрные ${black} – Белые ${white} (${mode}) — Classic Reversi";

  static String m36(passed, current) =>
      "${passed}: нет допустимых ходов. ${current} ходят снова.";

  static String m37(step, total) => "Урок ${step} из ${total}";

  static String m38(wins, losses) => "Побед ${wins} · Поражений ${losses}";

  static String m39(color) => "Вы · ${color}";

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
    "AgainstComputer": MessageLookupByLibrary.simpleMessage("Компьютер"),
    "AnalysisAccuracy": MessageLookupByLibrary.simpleMessage("точность"),
    "AnalysisClean": MessageLookupByLibrary.simpleMessage(
      "Серьёзных ошибок нет. Отличная игра!",
    ),
    "AnalysisCounts": m3,
    "AnalysisInaccuracy": MessageLookupByLibrary.simpleMessage("Неточность"),
    "AnalysisKeyMoments": MessageLookupByLibrary.simpleMessage(
      "Ключевые моменты",
    ),
    "AnalysisLoading": MessageLookupByLibrary.simpleMessage(
      "Анализируем каждый ход…",
    ),
    "AnalysisLockedBody": MessageLookupByLibrary.simpleMessage(
      "Премиум оценивает точность, считает, как часто вы находили ход тренера, и показывает ключевые ошибки для разбора.",
    ),
    "AnalysisMistake": MessageLookupByLibrary.simpleMessage("Ошибка"),
    "AnalysisMoment": m4,
    "AnalysisNoMoves": MessageLookupByLibrary.simpleMessage(
      "В этой партии нет ходов для анализа.",
    ),
    "AnalysisTitle": MessageLookupByLibrary.simpleMessage("Анализ партии"),
    "BestStreak": MessageLookupByLibrary.simpleMessage("Лучшая серия"),
    "Black": MessageLookupByLibrary.simpleMessage("чёрные"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("Чёрные побеждают"),
    "BoardCell": m5,
    "BoardEmpty": MessageLookupByLibrary.simpleMessage("Пусто"),
    "BoardKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "Перемещайтесь по доске клавишами со стрелками. Нажмите Enter или пробел, чтобы сделать ход в отмеченную клетку.",
    ),
    "BoardLastMove": MessageLookupByLibrary.simpleMessage("Последний ход"),
    "BoardLegalMove": MessageLookupByLibrary.simpleMessage("Допустимый ход"),
    "BoardReviewKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "Перемещайтесь по доске клавишами со стрелками.",
    ),
    "BoardSuggestedMove": MessageLookupByLibrary.simpleMessage(
      "Рекомендует тренер",
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
    "CoachComparison": m6,
    "CoachCorner": MessageLookupByLibrary.simpleMessage(
      "Этот ход занимает угол. Угловую фишку невозможно перевернуть.",
    ),
    "CoachEndsGame": MessageLookupByLibrary.simpleMessage(
      "После этого хода ни одна сторона не может ходить. Партия заканчивается.",
    ),
    "CoachForPlayer": m7,
    "CoachJump": MessageLookupByLibrary.simpleMessage("Перейти к этой позиции"),
    "CoachMatched": m8,
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
    "CoachReplies": m9,
    "CoachScope": MessageLookupByLibrary.simpleMessage(
      "Неглубокий поиск предлагает идеи для разбора, но не гарантирует самый сильный ход.",
    ),
    "CoachShareResult": MessageLookupByLibrary.simpleMessage(
      "Поделиться результатом",
    ),
    "CoachSuggested": m10,
    "CoachTip": MessageLookupByLibrary.simpleMessage("Совет тренера"),
    "CoachTipLimitMessage": m11,
    "CoachTipLimitTitle": MessageLookupByLibrary.simpleMessage(
      "Бесплатные советы на сегодня закончились",
    ),
    "CoachTipSuggestion": m12,
    "CoachTipWatchAd": MessageLookupByLibrary.simpleMessage("Смотреть рекламу"),
    "CoachTipWithAd": MessageLookupByLibrary.simpleMessage(
      "Совет тренера · смотреть рекламу",
    ),
    "CoachTipsLeft": m13,
    "CoachTitle": MessageLookupByLibrary.simpleMessage("Тренер по стратегии"),
    "CoachTurnTitle": MessageLookupByLibrary.simpleMessage(
      "Позиция, к которой стоит вернуться",
    ),
    "CoachUnavailable": MessageLookupByLibrary.simpleMessage(
      "Сейчас разбор недоступен. Вы по-прежнему можете просмотреть все ходы.",
    ),
    "ComputerColor": m14,
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
    "DifficultyExpert": MessageLookupByLibrary.simpleMessage("Эксперт"),
    "DifficultyHard": MessageLookupByLibrary.simpleMessage("Сложный"),
    "DifficultyMedium": MessageLookupByLibrary.simpleMessage("Средний"),
    "DifficultySuperEasy": MessageLookupByLibrary.simpleMessage("Очень лёгкий"),
    "ExpertSetupNote": MessageLookupByLibrary.simpleMessage(
      "«Эксперт» считает глубже и безупречно играет эндшпиль. Ему может потребоваться время на раздумья.",
    ),
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
    "GameSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось сохранить игру. Повторите попытку перед выходом.",
    ),
    "GameSetup": MessageLookupByLibrary.simpleMessage("Настройте игру"),
    "GameStatusAnnouncement": m15,
    "GamesPlayed": MessageLookupByLibrary.simpleMessage("Сыграно партий"),
    "GetPremium": MessageLookupByLibrary.simpleMessage("Получить Премиум"),
    "GetPremiumWithPrice": m16,
    "GoPremium": MessageLookupByLibrary.simpleMessage("Перейти на Премиум"),
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
    "PlayerTurn": m17,
    "PracticeBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Доска для тренировки стратегии",
    ),
    "PracticeFlipped": m18,
    "PracticeInstructions": MessageLookupByLibrary.simpleMessage(
      "Сыграйте в любую отмеченную клетку и изучите изменения.",
    ),
    "PracticeNoMoves": MessageLookupByLibrary.simpleMessage(
      "У этой стороны нет допустимых ходов в данной позиции.",
    ),
    "PracticePlayed": m19,
    "PracticeReset": MessageLookupByLibrary.simpleMessage(
      "Попробовать другой ход",
    ),
    "PracticeSafe": MessageLookupByLibrary.simpleMessage(
      "Тренировка не влияет на сохранённую партию и статистику.",
    ),
    "PracticeTitle": MessageLookupByLibrary.simpleMessage(
      "Попробуйте эту позицию",
    ),
    "Premium": MessageLookupByLibrary.simpleMessage("Премиум"),
    "PremiumActive": MessageLookupByLibrary.simpleMessage("Премиум активен"),
    "PremiumAdFreeBody": MessageLookupByLibrary.simpleMessage(
      "Никаких баннеров, рекламы при запуске и рекламы за награду.",
    ),
    "PremiumAdFreeTitle": MessageLookupByLibrary.simpleMessage("Без рекламы"),
    "PremiumAnalysisBody": MessageLookupByLibrary.simpleMessage(
      "Точность и ключевые ошибки каждой партии — переход к позиции одним касанием.",
    ),
    "PremiumAnalysisTitle": MessageLookupByLibrary.simpleMessage(
      "Полный анализ партии",
    ),
    "PremiumExpertBody": MessageLookupByLibrary.simpleMessage(
      "Сразитесь с сильнейшим компьютером: глубокий расчёт и идеальный эндшпиль.",
    ),
    "PremiumExpertTitle": MessageLookupByLibrary.simpleMessage(
      "Соперник «Эксперт»",
    ),
    "PremiumHeadline": MessageLookupByLibrary.simpleMessage(
      "Перейдите на Премиум",
    ),
    "PremiumHintsBody": MessageLookupByLibrary.simpleMessage(
      "Все допустимые клетки на уровнях «Средний», «Сложный» и «Эксперт» без рекламы.",
    ),
    "PremiumHintsTitle": MessageLookupByLibrary.simpleMessage(
      "Подсказки ходов везде",
    ),
    "PremiumIncludes": MessageLookupByLibrary.simpleMessage(
      "Что входит в Премиум",
    ),
    "PremiumOneTime": m20,
    "PremiumRequired": MessageLookupByLibrary.simpleMessage(
      "Требуется Премиум",
    ),
    "PremiumSettingsActiveSubtitle": MessageLookupByLibrary.simpleMessage(
      "Спасибо! Все функции Премиум открыты.",
    ),
    "PremiumSettingsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Без рекламы, безлимитные отмены и советы, ИИ «Эксперт» и многое другое",
    ),
    "PremiumSubheadline": MessageLookupByLibrary.simpleMessage(
      "Играйте без рекламы и откройте продвинутые инструменты, чтобы играть сильнее.",
    ),
    "PremiumThemeLabel": m21,
    "PremiumThemesBody": MessageLookupByLibrary.simpleMessage(
      "Темы «Королевская» и «Угли» — только для Премиум.",
    ),
    "PremiumThemesTitle": MessageLookupByLibrary.simpleMessage(
      "Эксклюзивные темы доски",
    ),
    "PremiumTipsBody": m22,
    "PremiumTipsTitle": MessageLookupByLibrary.simpleMessage(
      "Безлимитные советы тренера",
    ),
    "PremiumUndoBody": MessageLookupByLibrary.simpleMessage(
      "Отменяйте сколько угодно ходов на любом уровне сложности.",
    ),
    "PremiumUndoTitle": MessageLookupByLibrary.simpleMessage(
      "Безлимитная отмена",
    ),
    "PremiumWelcomeBody": MessageLookupByLibrary.simpleMessage(
      "Спасибо за поддержку! Все функции Премиум открыты.",
    ),
    "PremiumWelcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Вы — Премиум-игрок",
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
      "У вас уже есть Премиум.",
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
      "Добро пожаловать в Премиум! Все функции открыты.",
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
    "PuzzleCornerObjective": m23,
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
    "PuzzleEndgameObjective": m24,
    "PuzzleEndgameSkill": MessageLookupByLibrary.simpleMessage(
      "Завершите победой",
    ),
    "PuzzleEndgameSuccess": MessageLookupByLibrary.simpleMessage(
      "Эндшпиль выигран. Ваши решения устояли против лучших ответов соперника.",
    ),
    "PuzzleEndgameTryAgain": MessageLookupByLibrary.simpleMessage(
      "Эта линия не гарантирует победу против лучшей игры. Начните заново и сравните другой ход.",
    ),
    "PuzzleHint": m25,
    "PuzzleHintCoordinate": m26,
    "PuzzleNext": MessageLookupByLibrary.simpleMessage("Следующая задача"),
    "PuzzleNoResults": MessageLookupByLibrary.simpleMessage(
      "Подходящих задач нет. Попробуйте название навыка или номер задачи.",
    ),
    "PuzzleNumber": m27,
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
    "PuzzlePassObjective": m28,
    "PuzzlePassSkill": MessageLookupByLibrary.simpleMessage(
      "Получите ещё один ход",
    ),
    "PuzzlePassSuccess": MessageLookupByLibrary.simpleMessage(
      "Вы получили ещё один ход. У соперника нет допустимого хода, и партия продолжается.",
    ),
    "PuzzleProgress": m29,
    "PuzzleProgressLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить прогресс задач. Повторите попытку.",
    ),
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
    "RestorePurchaseHelp": m30,
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
    "ResultCardPreviewLabel": m31,
    "ResultCardShareFailed": MessageLookupByLibrary.simpleMessage(
      "Сейчас не удаётся поделиться. Попробуйте ещё раз.",
    ),
    "ResultCardTitle": MessageLookupByLibrary.simpleMessage(
      "Поделиться результатом",
    ),
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Доска разбора партии",
    ),
    "ReviewCorners": m32,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("Конечная позиция"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("К началу"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("Разбор партии"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("К концу"),
    "ReviewMove": m33,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("Следующий ход"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage("Предыдущий ход"),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("Начальная позиция"),
    "Rules": MessageLookupByLibrary.simpleMessage("Правила"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ваша доска ждёт вас.",
    ),
    "SavedMatchScore": m34,
    "Settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "Share": MessageLookupByLibrary.simpleMessage("Поделиться"),
    "ShareResult": m35,
    "Sound": MessageLookupByLibrary.simpleMessage("Звук"),
    "StartGame": MessageLookupByLibrary.simpleMessage("Начать игру"),
    "StartNewGame": MessageLookupByLibrary.simpleMessage("Начать новую игру"),
    "Stats": MessageLookupByLibrary.simpleMessage("Статистика"),
    "Theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "ThemeClassic": MessageLookupByLibrary.simpleMessage("Классика"),
    "ThemeContrast": MessageLookupByLibrary.simpleMessage("Контраст"),
    "ThemeEmber": MessageLookupByLibrary.simpleMessage("Угли"),
    "ThemeNight": MessageLookupByLibrary.simpleMessage("Ночь"),
    "ThemeRoyal": MessageLookupByLibrary.simpleMessage("Королевская"),
    "Tie": MessageLookupByLibrary.simpleMessage("Ничья"),
    "Ties": MessageLookupByLibrary.simpleMessage("Ничьи"),
    "TryAgain": MessageLookupByLibrary.simpleMessage("Попробовать ещё раз"),
    "TurnPassed": m36,
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
    "TutorialProgress": m37,
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
    "UndoUnlimited": MessageLookupByLibrary.simpleMessage(
      "Отменить ход · без ограничений",
    ),
    "UndoWithAd": MessageLookupByLibrary.simpleMessage(
      "Отменить ход · смотреть рекламу",
    ),
    "UnlockWithPremium": MessageLookupByLibrary.simpleMessage(
      "Открыть с Премиум",
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
    "WinsLosses": m38,
    "YouColor": m39,
    "YouLose": MessageLookupByLibrary.simpleMessage("Вы проиграли"),
    "YouWin": MessageLookupByLibrary.simpleMessage("Вы победили!"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("Ваш ход"),
  };
}
