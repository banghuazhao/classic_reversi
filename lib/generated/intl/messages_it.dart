// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static String m0(current, target) => "Partite: ${current} di ${target}";

  static String m1(current, target) =>
      "Vittorie consecutive: ${current} di ${target}";

  static String m2(current, target) => "Vittorie: ${current} di ${target}";

  static String m3(best, good, inaccuracies, mistakes) =>
      "Migliori ${best} · Buone ${good} · Imprecisioni ${inaccuracies} · Errori ${mistakes}";

  static String m4(move, played, suggested) =>
      "Mossa ${move}: giocata ${played}, ${suggested} era migliore";

  static String m5(coordinate, piece) => "${coordinate}, ${piece}";

  static String m6(actual, suggested) =>
      "Giocata: ${actual} · Da esplorare: ${suggested}";

  static String m7(player) => "Idee per ${player}";

  static String m8(coordinate) =>
      "Hai giocato ${coordinate}. Riscopri le idee di questa mossa.";

  static String m9(count) => "Risposte consentite all’avversario: ${count}.";

  static String m10(coordinate) => "Mossa suggerita: ${coordinate}";

  static String m11(count) =>
      "Hai usato tutti i ${count} consigli gratuiti di oggi. Guarda un breve annuncio per averne un altro, oppure passa a Premium per consigli illimitati.";

  static String m12(count) =>
      "Hai usato tutti i ${count} consigli del coach gratuiti di oggi. Passa a Premium per consigli illimitati, oppure torna domani.";

  static String m13(coordinate) => "Consiglio: prova ${coordinate}.";

  static String m14(count) => "Consiglio del coach · ${count} gratis oggi";

  static String m15(color) => "Computer · ${color}";

  static String m16(status, black, white) =>
      "${status}. Nero ${black}, bianco ${white}.";

  static String m17(price) => "Ottieni Premium · ${price}";

  static String m18(color) => "Tocca al ${color}";

  static String m19(count) => "Dischi capovolti: ${count}";

  static String m20(coordinate) => "Hai giocato ${coordinate}";

  static String m21(store) =>
      "Un solo pagamento. Nessun abbonamento. Ripristina quando vuoi con il tuo account ${store}.";

  static String m22(theme) => "${theme} · Premium";

  static String m23(count) =>
      "Scopri una mossa forte e il perché, in qualsiasi momento. Senza Premium hai ${count} consigli al giorno.";

  static String m24(color, coordinate) =>
      "Gioca con il ${color}. Conquista l’angolo ${coordinate} in una mossa.";

  static String m25(color) =>
      "Gioca con il ${color}. Vinci questo finale contro le migliori risposte.";

  static String m26(number) => "Suggerimento ${number} di 3";

  static String m27(coordinate) => "Prova ${coordinate}.";

  static String m28(number) => "Esercizio ${number}";

  static String m29(color) =>
      "Gioca con il ${color}. Costringi l’avversario a passare per giocare di nuovo, senza terminare la partita.";

  static String m30(completed, total) => "${completed} di ${total} risolti";

  static String m31(store) =>
      "Hai già acquistato? Ripristina dal tuo account ${store}.";

  static String m32(result, score, mode, date) =>
      "${result}. ${score}. ${mode}. ${date}.";

  static String m33(black, white) => "Angoli · Nero ${black} · Bianco ${white}";

  static String m34(move, total) => "Mossa ${move} di ${total}";

  static String m35(black, white) => "Nero ${black} · Bianco ${white}";

  static String m36(result, black, white, mode) =>
      "${result} · Nero ${black} – Bianco ${white} (${mode}) — Classic Reversi";

  static String m37(passed, current) =>
      "Nessuna mossa valida per ${passed}. Muove ancora ${current}.";

  static String m38(step, total) => "Lezione ${step} di ${total}";

  static String m39(wins, losses) => "Vittorie ${wins} · Sconfitte ${losses}";

  static String m40(color) => "Tu · ${color}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "Accessibility": MessageLookupByLibrary.simpleMessage("Accessibilità"),
    "AchDailyChallenge": MessageLookupByLibrary.simpleMessage(
      "Campione giornaliero",
    ),
    "AchFirstWin": MessageLookupByLibrary.simpleMessage("Prima vittoria"),
    "AchGames10": MessageLookupByLibrary.simpleMessage("10 partite"),
    "AchGames50": MessageLookupByLibrary.simpleMessage("50 partite"),
    "AchPerfectGame": MessageLookupByLibrary.simpleMessage("Partita perfetta"),
    "AchWinHard": MessageLookupByLibrary.simpleMessage("Vittoria in Difficile"),
    "AchWinStreak3": MessageLookupByLibrary.simpleMessage("Serie di 3"),
    "AchWinStreak5": MessageLookupByLibrary.simpleMessage("Serie di 5"),
    "AchievementGamesProgress": m0,
    "AchievementStreakProgress": m1,
    "AchievementUnlocked": MessageLookupByLibrary.simpleMessage(
      "Obiettivo sbloccato",
    ),
    "AchievementWinsProgress": m2,
    "Achievements": MessageLookupByLibrary.simpleMessage("Obiettivi"),
    "AdFailed": MessageLookupByLibrary.simpleMessage(
      "Annuncio non disponibile. Riprova più tardi.",
    ),
    "AdLoading": MessageLookupByLibrary.simpleMessage("Caricamento annuncio…"),
    "AgainstComputer": MessageLookupByLibrary.simpleMessage("Computer"),
    "AnalysisAccuracy": MessageLookupByLibrary.simpleMessage("precisione"),
    "AnalysisClean": MessageLookupByLibrary.simpleMessage(
      "Nessun errore grave. Ben giocato!",
    ),
    "AnalysisCounts": m3,
    "AnalysisInaccuracy": MessageLookupByLibrary.simpleMessage("Imprecisione"),
    "AnalysisKeyMoments": MessageLookupByLibrary.simpleMessage(
      "Momenti chiave",
    ),
    "AnalysisLoading": MessageLookupByLibrary.simpleMessage(
      "Analisi di tutte le mosse…",
    ),
    "AnalysisLockedBody": MessageLookupByLibrary.simpleMessage(
      "Premium valuta la tua precisione, conta quante volte hai trovato la mossa del coach ed elenca gli errori chiave da rivedere.",
    ),
    "AnalysisMistake": MessageLookupByLibrary.simpleMessage("Errore"),
    "AnalysisMoment": m4,
    "AnalysisNoMoves": MessageLookupByLibrary.simpleMessage(
      "In questa partita non ci sono decisioni da analizzare.",
    ),
    "AnalysisTitle": MessageLookupByLibrary.simpleMessage(
      "Analisi della partita",
    ),
    "BestStreak": MessageLookupByLibrary.simpleMessage("Miglior serie"),
    "Black": MessageLookupByLibrary.simpleMessage("nero"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("Vince il nero"),
    "BoardCell": m5,
    "BoardEmpty": MessageLookupByLibrary.simpleMessage("Vuota"),
    "BoardKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "Usa i tasti freccia per esplorare la scacchiera e Invio o Spazio per giocare in una casella evidenziata.",
    ),
    "BoardLastMove": MessageLookupByLibrary.simpleMessage("Ultima mossa"),
    "BoardLegalMove": MessageLookupByLibrary.simpleMessage("Mossa valida"),
    "BoardReviewKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "Usa i tasti freccia per esplorare la scacchiera.",
    ),
    "BoardSuggestedMove": MessageLookupByLibrary.simpleMessage(
      "Suggerita dal coach",
    ),
    "Cancel": MessageLookupByLibrary.simpleMessage("Annulla"),
    "Classic_Reversi": MessageLookupByLibrary.simpleMessage("Classic Reversi"),
    "CoachAllowsCorner": MessageLookupByLibrary.simpleMessage(
      "L’avversario può conquistare un angolo al prossimo turno.",
    ),
    "CoachAnalyzing": MessageLookupByLibrary.simpleMessage(
      "Cerchiamo una posizione utile da esplorare…",
    ),
    "CoachAvoidCorner": MessageLookupByLibrary.simpleMessage(
      "Un’altra mossa consentita permette all’avversario di conquistare subito un angolo. Questa evita la minaccia.",
    ),
    "CoachComparison": m6,
    "CoachCorner": MessageLookupByLibrary.simpleMessage(
      "Questa mossa conquista un angolo. Un disco nell’angolo non può essere capovolto.",
    ),
    "CoachEndsGame": MessageLookupByLibrary.simpleMessage(
      "Dopo questa mossa nessuno dei due può giocare. La partita termina.",
    ),
    "CoachForPlayer": m7,
    "CoachJump": MessageLookupByLibrary.simpleMessage("Vai a questa posizione"),
    "CoachMatched": m8,
    "CoachNoPosition": MessageLookupByLibrary.simpleMessage(
      "Questa partita non contiene posizioni giocabili da esplorare.",
    ),
    "CoachPass": MessageLookupByLibrary.simpleMessage(
      "L’avversario non ha risposte consentite, quindi giochi di nuovo.",
    ),
    "CoachPositionTitle": MessageLookupByLibrary.simpleMessage(
      "Esplora questa posizione",
    ),
    "CoachPractice": MessageLookupByLibrary.simpleMessage(
      "Prova questa posizione",
    ),
    "CoachReplies": m9,
    "CoachScope": MessageLookupByLibrary.simpleMessage(
      "Una ricerca breve suggerisce idee da esplorare, ma non garantisce la mossa più forte.",
    ),
    "CoachShareResult": MessageLookupByLibrary.simpleMessage(
      "Condividi risultato",
    ),
    "CoachSuggested": m10,
    "CoachTip": MessageLookupByLibrary.simpleMessage("Consiglio del coach"),
    "CoachTipLimitMessage": m11,
    "CoachTipLimitPremiumMessage": m12,
    "CoachTipLimitTitle": MessageLookupByLibrary.simpleMessage(
      "Consigli gratuiti di oggi esauriti",
    ),
    "CoachTipSuggestion": m13,
    "CoachTipWatchAd": MessageLookupByLibrary.simpleMessage("Guarda annuncio"),
    "CoachTipWithAd": MessageLookupByLibrary.simpleMessage(
      "Consiglio del coach · guarda un annuncio",
    ),
    "CoachTipWithPremium": MessageLookupByLibrary.simpleMessage(
      "Consiglio del coach · Premium",
    ),
    "CoachTipsLeft": m14,
    "CoachTitle": MessageLookupByLibrary.simpleMessage(
      "Allenatore di strategia",
    ),
    "CoachTurnTitle": MessageLookupByLibrary.simpleMessage(
      "Una posizione da rivedere",
    ),
    "CoachUnavailable": MessageLookupByLibrary.simpleMessage(
      "L’analisi non è disponibile al momento. Puoi comunque rivedere tutte le mosse.",
    ),
    "ComputerColor": m15,
    "ComputerThinking": MessageLookupByLibrary.simpleMessage(
      "Il computer sta pensando…",
    ),
    "ContinueGame": MessageLookupByLibrary.simpleMessage("Continua la partita"),
    "CurrentStreak": MessageLookupByLibrary.simpleMessage("Serie di vittorie"),
    "DailyChallenge": MessageLookupByLibrary.simpleMessage("Sfida giornaliera"),
    "DailyChallengeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Batti il puzzle di oggi in Difficile",
    ),
    "DailyCompleted": MessageLookupByLibrary.simpleMessage(
      "Completata oggi — puoi rigiocare",
    ),
    "Delete": MessageLookupByLibrary.simpleMessage("Elimina"),
    "DeleteSavedMatch": MessageLookupByLibrary.simpleMessage("Elimina partita"),
    "DeleteSavedMatchMessage": MessageLookupByLibrary.simpleMessage(
      "Questa registrazione verrà rimossa dall’archivio. Le tue statistiche resteranno invariate.",
    ),
    "DeleteSavedMatchTitle": MessageLookupByLibrary.simpleMessage(
      "Eliminare questa partita?",
    ),
    "Difficulty": MessageLookupByLibrary.simpleMessage("Difficoltà"),
    "DifficultyEasy": MessageLookupByLibrary.simpleMessage("Facile"),
    "DifficultyExpert": MessageLookupByLibrary.simpleMessage("Esperto"),
    "DifficultyHard": MessageLookupByLibrary.simpleMessage("Difficile"),
    "DifficultyMedium": MessageLookupByLibrary.simpleMessage("Medio"),
    "DifficultySuperEasy": MessageLookupByLibrary.simpleMessage("Facilissimo"),
    "ExpertSetupNote": MessageLookupByLibrary.simpleMessage(
      "Esperto calcola più a fondo e gioca i finali alla perfezione. Potrebbe pensare qualche istante.",
    ),
    "FeedbackBalanced": MessageLookupByLibrary.simpleMessage("Bilanciata"),
    "FeedbackGentle": MessageLookupByLibrary.simpleMessage("Delicata"),
    "FeedbackIntensity": MessageLookupByLibrary.simpleMessage(
      "Intensità feedback",
    ),
    "FeedbackLively": MessageLookupByLibrary.simpleMessage("Vivace"),
    "FirstPlayerComputer": MessageLookupByLibrary.simpleMessage("Computer"),
    "FirstPlayerHuman": MessageLookupByLibrary.simpleMessage("Giocatore"),
    "FirstPlayerRandom": MessageLookupByLibrary.simpleMessage("Casuale"),
    "GameOver": MessageLookupByLibrary.simpleMessage("Fine partita"),
    "GameSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Impossibile salvare la partita. Riprova prima di uscire.",
    ),
    "GameSetup": MessageLookupByLibrary.simpleMessage("Imposta la partita"),
    "GameStatusAnnouncement": m16,
    "GamesPlayed": MessageLookupByLibrary.simpleMessage("Partite giocate"),
    "GetPremium": MessageLookupByLibrary.simpleMessage("Ottieni Premium"),
    "GetPremiumWithPrice": m17,
    "GoPremium": MessageLookupByLibrary.simpleMessage("Passa a Premium"),
    "GuidedFirstGame": MessageLookupByLibrary.simpleMessage(
      "Impara con una partita guidata",
    ),
    "GuidedFirstGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "Esercitati a catturare le pedine, conquista gli angoli e trova il tuo ritmo.",
    ),
    "Haptics": MessageLookupByLibrary.simpleMessage("Vibrazione"),
    "Help": MessageLookupByLibrary.simpleMessage("Aiuto"),
    "Hint": MessageLookupByLibrary.simpleMessage("Suggerimento"),
    "HintWithAd": MessageLookupByLibrary.simpleMessage(
      "Mosse valide · guarda un annuncio",
    ),
    "HintWithPremium": MessageLookupByLibrary.simpleMessage(
      "Mosse valide · Premium",
    ),
    "HintsEnabled": MessageLookupByLibrary.simpleMessage(
      "Suggerimenti attivati per questa partita.",
    ),
    "Home": MessageLookupByLibrary.simpleMessage("Home"),
    "HomeTagline": MessageLookupByLibrary.simpleMessage(
      "Un po’ di strategia. Un momento per te.",
    ),
    "How_to_play": MessageLookupByLibrary.simpleMessage("Come si gioca?"),
    "How_to_play_explain": MessageLookupByLibrary.simpleMessage(
      "Nel gioco, tutti i dischi dell\'avversario allineati e compresi tra il disco appena posizionato e un altro disco del giocatore corrente vengono capovolti nel colore del giocatore corrente. L\'obiettivo del gioco è avere la maggioranza dei dischi del proprio colore quando l\'ultima casella vuota giocabile viene riempita.",
    ),
    "KeepPlaying": MessageLookupByLibrary.simpleMessage("Continua a giocare"),
    "MatchLibrary": MessageLookupByLibrary.simpleMessage(
      "Archivio delle partite",
    ),
    "MatchLibraryDeleteError": MessageLookupByLibrary.simpleMessage(
      "Impossibile eliminare questa partita. Riprova.",
    ),
    "MatchLibraryEmptyBody": MessageLookupByLibrary.simpleMessage(
      "Completa una partita e apparirà qui. Ripercorri ogni mossa e scopri nuove idee da provare.",
    ),
    "MatchLibraryEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "La tua storia inizia qui",
    ),
    "MatchLibraryLoadError": MessageLookupByLibrary.simpleMessage(
      "Impossibile caricare l’archivio delle partite.",
    ),
    "MatchLibraryOpen": MessageLookupByLibrary.simpleMessage(
      "Rivedi la partita",
    ),
    "MatchLibrarySaveError": MessageLookupByLibrary.simpleMessage(
      "Impossibile salvare questa partita nell’archivio.",
    ),
    "MatchLibrarySubtitle": MessageLookupByLibrary.simpleMessage(
      "Le tue ultime 100 partite completate, pronte da rivedere.",
    ),
    "MilestoneCompleted": MessageLookupByLibrary.simpleMessage("Completato"),
    "More": MessageLookupByLibrary.simpleMessage("Altro"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("Altre App"),
    "NewGame": MessageLookupByLibrary.simpleMessage("Nuova partita"),
    "NextMilestone": MessageLookupByLibrary.simpleMessage("Prossimo traguardo"),
    "OK": MessageLookupByLibrary.simpleMessage("OK"),
    "Opponent": MessageLookupByLibrary.simpleMessage("Avversario"),
    "PerfectWins": MessageLookupByLibrary.simpleMessage("Vittorie perfette"),
    "Play": MessageLookupByLibrary.simpleMessage("Gioca"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage(
      "Gioca con un amico su questo dispositivo",
    ),
    "PlayerTurn": m18,
    "PracticeBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Scacchiera per allenare la strategia",
    ),
    "PracticeFlipped": m19,
    "PracticeInstructions": MessageLookupByLibrary.simpleMessage(
      "Gioca in una casella evidenziata e osserva cosa cambia.",
    ),
    "PracticeNoMoves": MessageLookupByLibrary.simpleMessage(
      "Questo colore non ha mosse consentite in questa posizione.",
    ),
    "PracticePlayed": m20,
    "PracticeReset": MessageLookupByLibrary.simpleMessage(
      "Prova un’altra mossa",
    ),
    "PracticeSafe": MessageLookupByLibrary.simpleMessage(
      "L’allenamento non influisce sulla partita salvata né sulle statistiche.",
    ),
    "PracticeTitle": MessageLookupByLibrary.simpleMessage(
      "Prova questa posizione",
    ),
    "Premium": MessageLookupByLibrary.simpleMessage("Premium"),
    "PremiumActive": MessageLookupByLibrary.simpleMessage("Premium attivo"),
    "PremiumAdFreeBody": MessageLookupByLibrary.simpleMessage(
      "Niente banner, annunci all’apertura o annunci con premio.",
    ),
    "PremiumAdFreeTitle": MessageLookupByLibrary.simpleMessage(
      "Nessun annuncio",
    ),
    "PremiumAnalysisBody": MessageLookupByLibrary.simpleMessage(
      "Precisione ed errori chiave di ogni partita, a un tocco dalla posizione.",
    ),
    "PremiumAnalysisTitle": MessageLookupByLibrary.simpleMessage(
      "Analisi completa della partita",
    ),
    "PremiumExpertBody": MessageLookupByLibrary.simpleMessage(
      "Sfida il computer più forte, con calcolo più profondo e finali perfetti.",
    ),
    "PremiumExpertTitle": MessageLookupByLibrary.simpleMessage(
      "Avversario Esperto",
    ),
    "PremiumHeadline": MessageLookupByLibrary.simpleMessage("Sblocca Premium"),
    "PremiumHintsBody": MessageLookupByLibrary.simpleMessage(
      "Vedi tutte le caselle valide in Medio, Difficile ed Esperto senza annunci.",
    ),
    "PremiumHintsBodyNoAds": MessageLookupByLibrary.simpleMessage(
      "Vedi tutte le caselle valide in Medio, Difficile ed Esperto.",
    ),
    "PremiumHintsTitle": MessageLookupByLibrary.simpleMessage(
      "Suggerimenti ovunque",
    ),
    "PremiumIncludes": MessageLookupByLibrary.simpleMessage("Premium include"),
    "PremiumOneTime": m21,
    "PremiumRequired": MessageLookupByLibrary.simpleMessage("Richiede Premium"),
    "PremiumSettingsActiveSubtitle": MessageLookupByLibrary.simpleMessage(
      "Grazie! Tutte le funzioni Premium sono sbloccate.",
    ),
    "PremiumSettingsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Senza annunci, annullamenti e consigli illimitati, IA Esperto e altro",
    ),
    "PremiumSubheadline": MessageLookupByLibrary.simpleMessage(
      "Gioca senza annunci e sblocca strumenti avanzati per migliorare ogni partita.",
    ),
    "PremiumSubheadlineNoAds": MessageLookupByLibrary.simpleMessage(
      "Sblocca strumenti avanzati per migliorare ogni partita.",
    ),
    "PremiumThemeLabel": m22,
    "PremiumThemesBody": MessageLookupByLibrary.simpleMessage(
      "I tavoli Reale e Brace, riservati a Premium.",
    ),
    "PremiumThemesTitle": MessageLookupByLibrary.simpleMessage(
      "Temi esclusivi",
    ),
    "PremiumTipsBody": m23,
    "PremiumTipsTitle": MessageLookupByLibrary.simpleMessage(
      "Consigli illimitati",
    ),
    "PremiumUndoBody": MessageLookupByLibrary.simpleMessage(
      "Annulla tutte le mosse che vuoi, a ogni livello di difficoltà.",
    ),
    "PremiumUndoTitle": MessageLookupByLibrary.simpleMessage(
      "Annullamenti illimitati",
    ),
    "PremiumWelcomeBody": MessageLookupByLibrary.simpleMessage(
      "Grazie per il tuo supporto. Tutte le funzioni Premium sono sbloccate.",
    ),
    "PremiumWelcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Sei un giocatore Premium",
    ),
    "PrivacyOptions": MessageLookupByLibrary.simpleMessage("Opzioni privacy"),
    "PrivacyOptionsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Aggiorna le tue scelte sulla privacy degli annunci",
    ),
    "PrivacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Informativa sulla privacy",
    ),
    "PrivacyPolicySubtitle": MessageLookupByLibrary.simpleMessage(
      "Come gestiamo dati e annunci",
    ),
    "PurchaseAlreadyOwned": MessageLookupByLibrary.simpleMessage(
      "Possiedi già Premium.",
    ),
    "PurchaseCancelled": MessageLookupByLibrary.simpleMessage(
      "Acquisto annullato.",
    ),
    "PurchaseFailed": MessageLookupByLibrary.simpleMessage(
      "Acquisto non riuscito. Riprova.",
    ),
    "PurchasePending": MessageLookupByLibrary.simpleMessage(
      "Acquisto in attesa di approvazione…",
    ),
    "PurchaseSuccess": MessageLookupByLibrary.simpleMessage(
      "Benvenuto in Premium! Ora tutte le funzioni sono sbloccate.",
    ),
    "PurchaseUnavailable": MessageLookupByLibrary.simpleMessage(
      "Gli acquisti non sono al momento disponibili.",
    ),
    "PuzzleAllComplete": MessageLookupByLibrary.simpleMessage(
      "Tutti e nove gli esercizi sono risolti. Rivisita qualsiasi posizione per affinare il tuo gioco.",
    ),
    "PuzzleBackToArchive": MessageLookupByLibrary.simpleMessage(
      "Torna agli esercizi",
    ),
    "PuzzleBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Scacchiera dell’esercizio",
    ),
    "PuzzleCompleted": MessageLookupByLibrary.simpleMessage("Risolto"),
    "PuzzleCompletionSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Impossibile salvare i progressi. Tieni aperta questa schermata e riprova.",
    ),
    "PuzzleCornerDescription": MessageLookupByLibrary.simpleMessage(
      "Individua un angolo sicuro e chiudi la linea di cattura.",
    ),
    "PuzzleCornerHintOne": MessageLookupByLibrary.simpleMessage(
      "I dischi negli angoli non possono essere capovolti. Cerca una linea da chiudere.",
    ),
    "PuzzleCornerHintTwo": MessageLookupByLibrary.simpleMessage(
      "Segui la linea dall’angolo indicato verso l’interno finché un tuo disco non chiude la fila avversaria.",
    ),
    "PuzzleCornerObjective": m24,
    "PuzzleCornerSkill": MessageLookupByLibrary.simpleMessage(
      "Conquista un angolo",
    ),
    "PuzzleCornerSuccess": MessageLookupByLibrary.simpleMessage(
      "Angolo conquistato. Questo disco resterà tuo fino alla fine della partita.",
    ),
    "PuzzleEndgameDescription": MessageLookupByLibrary.simpleMessage(
      "Gioca le ultime mosse contro le migliori risposte.",
    ),
    "PuzzleEndgameHintOne": MessageLookupByLibrary.simpleMessage(
      "Il conteggio finale dei dischi decide il vincitore. Calcola fino alla fine.",
    ),
    "PuzzleEndgameHintTwo": MessageLookupByLibrary.simpleMessage(
      "Confronta le risposte dell’avversario. Una cattura più piccola può lasciarti l’ultima mossa.",
    ),
    "PuzzleEndgameObjective": m25,
    "PuzzleEndgameSkill": MessageLookupByLibrary.simpleMessage(
      "Concludi con una vittoria",
    ),
    "PuzzleEndgameSuccess": MessageLookupByLibrary.simpleMessage(
      "Finale vinto. Le tue scelte hanno retto alle migliori risposte.",
    ),
    "PuzzleEndgameTryAgain": MessageLookupByLibrary.simpleMessage(
      "Questa linea non garantisce la vittoria contro il gioco migliore. Ricomincia e confronta un’altra mossa.",
    ),
    "PuzzleHint": m26,
    "PuzzleHintCoordinate": m27,
    "PuzzleNext": MessageLookupByLibrary.simpleMessage("Esercizio successivo"),
    "PuzzleNoResults": MessageLookupByLibrary.simpleMessage(
      "Nessun esercizio corrispondente. Prova un’abilità o il numero dell’esercizio.",
    ),
    "PuzzleNumber": m28,
    "PuzzleOpponentThinking": MessageLookupByLibrary.simpleMessage(
      "Valutazione della risposta migliore…",
    ),
    "PuzzlePassDescription": MessageLookupByLibrary.simpleMessage(
      "Lascia l’avversario senza mosse consentite.",
    ),
    "PuzzlePassHintOne": MessageLookupByLibrary.simpleMessage(
      "Si passa solo quando l’avversario non ha mosse consentite.",
    ),
    "PuzzlePassHintTwo": MessageLookupByLibrary.simpleMessage(
      "Confronta le mosse disponibili all’avversario dopo ciascuna delle tue possibili mosse.",
    ),
    "PuzzlePassObjective": m29,
    "PuzzlePassSkill": MessageLookupByLibrary.simpleMessage(
      "Guadagna un altro turno",
    ),
    "PuzzlePassSuccess": MessageLookupByLibrary.simpleMessage(
      "Hai guadagnato un altro turno. L’avversario non ha mosse consentite e la partita continua.",
    ),
    "PuzzleProgress": m30,
    "PuzzleProgressLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Impossibile caricare i progressi dei rompicapi. Riprova.",
    ),
    "PuzzleRestart": MessageLookupByLibrary.simpleMessage(
      "Ricomincia l’esercizio",
    ),
    "PuzzleRevealHint": MessageLookupByLibrary.simpleMessage(
      "Mostra un suggerimento",
    ),
    "PuzzleSaveProgress": MessageLookupByLibrary.simpleMessage(
      "Salva progressi",
    ),
    "PuzzleSearch": MessageLookupByLibrary.simpleMessage("Cerca esercizi"),
    "PuzzleTryAgain": MessageLookupByLibrary.simpleMessage(
      "Questa mossa non risolve la posizione. Ricomincia e prova un’altra linea.",
    ),
    "PuzzleYourMove": MessageLookupByLibrary.simpleMessage("Tocca a te"),
    "Puzzles": MessageLookupByLibrary.simpleMessage("Esercizi di strategia"),
    "PuzzlesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Nove posizioni scelte con cura. Sviluppa un’abilità alla volta.",
    ),
    "ReduceMotion": MessageLookupByLibrary.simpleMessage("Riduci movimento"),
    "ReduceMotionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Riduce al minimo il movimento delle pedine e gli effetti di festa",
    ),
    "Rematch": MessageLookupByLibrary.simpleMessage("Rivincita"),
    "ReplaceSavedGameMessage": MessageLookupByLibrary.simpleMessage(
      "La partita in corso verrà sostituita. Puoi continuare a giocarla dalla schermata iniziale.",
    ),
    "ReplaceSavedGameTitle": MessageLookupByLibrary.simpleMessage(
      "Iniziare una nuova partita?",
    ),
    "RestartConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "La posizione attuale verrà sostituita da quella iniziale.",
    ),
    "RestartConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Ricominciare questa partita?",
    ),
    "RestartGame": MessageLookupByLibrary.simpleMessage("Riavvia partita"),
    "RestoreNothing": MessageLookupByLibrary.simpleMessage(
      "Nessun acquisto da ripristinare.",
    ),
    "RestorePurchaseHelp": m31,
    "RestorePurchases": MessageLookupByLibrary.simpleMessage(
      "Ripristina acquisti",
    ),
    "RestoreSuccess": MessageLookupByLibrary.simpleMessage(
      "Acquisti ripristinati.",
    ),
    "ResultCardError": MessageLookupByLibrary.simpleMessage(
      "Impossibile creare la scheda del risultato.",
    ),
    "ResultCardPreparing": MessageLookupByLibrary.simpleMessage(
      "Creazione della scheda del risultato…",
    ),
    "ResultCardPreviewLabel": m32,
    "ResultCardShareFailed": MessageLookupByLibrary.simpleMessage(
      "La condivisione non è disponibile al momento. Riprova.",
    ),
    "ResultCardTitle": MessageLookupByLibrary.simpleMessage(
      "Condividi il risultato",
    ),
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Scacchiera di revisione della partita",
    ),
    "ReviewCorners": m33,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("Posizione finale"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("Vai all’inizio"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("Rivedi la partita"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("Vai alla fine"),
    "ReviewMove": m34,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("Mossa successiva"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage("Mossa precedente"),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("Posizione iniziale"),
    "Rules": MessageLookupByLibrary.simpleMessage("Regole"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "La tua scacchiera ti aspetta.",
    ),
    "SavedMatchScore": m35,
    "Settings": MessageLookupByLibrary.simpleMessage("Impostazioni"),
    "Share": MessageLookupByLibrary.simpleMessage("Condividi"),
    "ShareResult": m36,
    "Sound": MessageLookupByLibrary.simpleMessage("Suoni"),
    "StartGame": MessageLookupByLibrary.simpleMessage("Inizia partita"),
    "StartNewGame": MessageLookupByLibrary.simpleMessage(
      "Inizia una nuova partita",
    ),
    "Stats": MessageLookupByLibrary.simpleMessage("Statistiche"),
    "Theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "ThemeClassic": MessageLookupByLibrary.simpleMessage("Classico"),
    "ThemeContrast": MessageLookupByLibrary.simpleMessage("Contrasto"),
    "ThemeEmber": MessageLookupByLibrary.simpleMessage("Brace"),
    "ThemeNight": MessageLookupByLibrary.simpleMessage("Notte"),
    "ThemeRoyal": MessageLookupByLibrary.simpleMessage("Reale"),
    "Tie": MessageLookupByLibrary.simpleMessage("Pareggio"),
    "Ties": MessageLookupByLibrary.simpleMessage("Pareggi"),
    "TryAgain": MessageLookupByLibrary.simpleMessage("Riprova"),
    "TurnPassed": m37,
    "TutorialBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Scacchiera di allenamento",
    ),
    "TutorialCaptureBody": MessageLookupByLibrary.simpleMessage(
      "Giochi con il nero. Tocca una casella evidenziata per intrappolare una pedina bianca tra due pedine nere.",
    ),
    "TutorialCaptureDoneBody": MessageLookupByLibrary.simpleMessage(
      "La pedina bianca intrappolata diventa nera. Ora tocca al bianco, poi sarà di nuovo il tuo turno.",
    ),
    "TutorialCaptureDoneTitle": MessageLookupByLibrary.simpleMessage(
      "Ecco una cattura",
    ),
    "TutorialCaptureTitle": MessageLookupByLibrary.simpleMessage(
      "Esegui la prima cattura",
    ),
    "TutorialCompleteBody": MessageLookupByLibrary.simpleMessage(
      "Vinci se alla fine hai più pedine. Se non hai mosse valide, il turno passa automaticamente. Inizia dal livello Facile e aumenta la difficoltà quando te la senti.",
    ),
    "TutorialCompleteTitle": MessageLookupByLibrary.simpleMessage(
      "Ora puoi iniziare",
    ),
    "TutorialCornersBody": MessageLookupByLibrary.simpleMessage(
      "Prova questa posizione di allenamento. Tocca l’angolo evidenziato in A1. Una pedina in un angolo non può essere capovolta.",
    ),
    "TutorialCornersTitle": MessageLookupByLibrary.simpleMessage(
      "Conquista un angolo",
    ),
    "TutorialNext": MessageLookupByLibrary.simpleMessage("Continua"),
    "TutorialPlayEasy": MessageLookupByLibrary.simpleMessage(
      "Gioca una partita Facile",
    ),
    "TutorialProgress": m38,
    "TutorialReplyBody": MessageLookupByLibrary.simpleMessage(
      "Il bianco ha giocato. Tocca una casella evidenziata per eseguire un’altra cattura.",
    ),
    "TutorialReplyDoneBody": MessageLookupByLibrary.simpleMessage(
      "Hai completato un turno. Ora prova a conquistare un angolo in una posizione di allenamento.",
    ),
    "TutorialSkip": MessageLookupByLibrary.simpleMessage("Salta il tutorial"),
    "TutorialTitle": MessageLookupByLibrary.simpleMessage("Impara giocando"),
    "TwoPlayersMode": MessageLookupByLibrary.simpleMessage(
      "2 giocatori (a turno)",
    ),
    "Undo": MessageLookupByLibrary.simpleMessage("Annulla"),
    "UndoUnlimited": MessageLookupByLibrary.simpleMessage(
      "Annulla · illimitato",
    ),
    "UndoWithAd": MessageLookupByLibrary.simpleMessage(
      "Annulla · guarda un annuncio",
    ),
    "UndoWithPremium": MessageLookupByLibrary.simpleMessage(
      "Annulla · Premium",
    ),
    "UnlockWithPremium": MessageLookupByLibrary.simpleMessage(
      "Sblocca con Premium",
    ),
    "Watch": MessageLookupByLibrary.simpleMessage("Guarda"),
    "WatchAd": MessageLookupByLibrary.simpleMessage("Guarda annuncio"),
    "WatchAdForHint": MessageLookupByLibrary.simpleMessage(
      "Guarda un breve annuncio per mostrare le mosse legali.",
    ),
    "WatchAdForUndo": MessageLookupByLibrary.simpleMessage(
      "Guarda un breve annuncio per annullare l\'ultima mossa.",
    ),
    "White": MessageLookupByLibrary.simpleMessage("bianco"),
    "WhiteWins": MessageLookupByLibrary.simpleMessage("Vince il bianco"),
    "WhoGoesFirst": MessageLookupByLibrary.simpleMessage("Chi inizia?"),
    "WinRate": MessageLookupByLibrary.simpleMessage("Percentuale vittorie"),
    "WinsByDifficulty": MessageLookupByLibrary.simpleMessage(
      "Vittorie per difficoltà",
    ),
    "WinsLosses": m39,
    "YouColor": m40,
    "YouLose": MessageLookupByLibrary.simpleMessage("Hai perso"),
    "YouWin": MessageLookupByLibrary.simpleMessage("Hai vinto!"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("Tocca a te"),
  };
}
