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

  static String m3(coordinate, piece) => "${coordinate}, ${piece}";

  static String m4(actual, suggested) =>
      "Giocata: ${actual} · Da esplorare: ${suggested}";

  static String m5(player) => "Idee per ${player}";

  static String m6(coordinate) =>
      "Hai giocato ${coordinate}. Riscopri le idee di questa mossa.";

  static String m7(count) => "Risposte consentite all’avversario: ${count}.";

  static String m8(coordinate) => "Mossa suggerita: ${coordinate}";

  static String m9(color) => "Computer · ${color}";

  static String m10(status, black, white) =>
      "${status}. Nero ${black}, bianco ${white}.";

  static String m11(color) => "Tocca al ${color}";

  static String m12(count) => "Dischi capovolti: ${count}";

  static String m13(coordinate) => "Hai giocato ${coordinate}";

  static String m14(color, coordinate) =>
      "Gioca con il ${color}. Conquista l’angolo ${coordinate} in una mossa.";

  static String m15(color) =>
      "Gioca con il ${color}. Vinci questo finale contro le migliori risposte.";

  static String m16(number) => "Suggerimento ${number} di 3";

  static String m17(coordinate) => "Prova ${coordinate}.";

  static String m18(number) => "Esercizio ${number}";

  static String m19(color) =>
      "Gioca con il ${color}. Costringi l’avversario a passare per giocare di nuovo, senza terminare la partita.";

  static String m20(completed, total) => "${completed} di ${total} risolti";

  static String m21(result, score, mode, date) =>
      "${result}. ${score}. ${mode}. ${date}.";

  static String m22(black, white) => "Angoli · Nero ${black} · Bianco ${white}";

  static String m23(move, total) => "Mossa ${move} di ${total}";

  static String m24(black, white) => "Nero ${black} · Bianco ${white}";

  static String m25(result, black, white, mode) =>
      "${result} · Nero ${black} – Bianco ${white} (${mode}) — Classic Reversi";

  static String m26(passed, current) =>
      "Nessuna mossa valida per ${passed}. Muove ancora ${current}.";

  static String m27(step, total) => "Lezione ${step} di ${total}";

  static String m28(wins, losses) => "Vittorie ${wins} · Sconfitte ${losses}";

  static String m29(color) => "Tu · ${color}";

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
    "AdsRemoved": MessageLookupByLibrary.simpleMessage("Annunci rimossi"),
    "AgainstComputer": MessageLookupByLibrary.simpleMessage("Computer"),
    "BestStreak": MessageLookupByLibrary.simpleMessage("Miglior serie"),
    "Black": MessageLookupByLibrary.simpleMessage("nero"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("Vince il nero"),
    "BoardCell": m3,
    "BoardEmpty": MessageLookupByLibrary.simpleMessage("Vuota"),
    "BoardKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "Usa i tasti freccia per esplorare la scacchiera e Invio o Spazio per giocare in una casella evidenziata.",
    ),
    "BoardLastMove": MessageLookupByLibrary.simpleMessage("Ultima mossa"),
    "BoardLegalMove": MessageLookupByLibrary.simpleMessage("Mossa valida"),
    "BoardReviewKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "Usa i tasti freccia per esplorare la scacchiera.",
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
    "CoachComparison": m4,
    "CoachCorner": MessageLookupByLibrary.simpleMessage(
      "Questa mossa conquista un angolo. Un disco nell’angolo non può essere capovolto.",
    ),
    "CoachEndsGame": MessageLookupByLibrary.simpleMessage(
      "Dopo questa mossa nessuno dei due può giocare. La partita termina.",
    ),
    "CoachForPlayer": m5,
    "CoachJump": MessageLookupByLibrary.simpleMessage("Vai a questa posizione"),
    "CoachMatched": m6,
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
    "CoachReplies": m7,
    "CoachScope": MessageLookupByLibrary.simpleMessage(
      "Una ricerca breve suggerisce idee da esplorare, ma non garantisce la mossa più forte.",
    ),
    "CoachShareResult": MessageLookupByLibrary.simpleMessage(
      "Condividi risultato",
    ),
    "CoachSuggested": m8,
    "CoachTitle": MessageLookupByLibrary.simpleMessage(
      "Allenatore di strategia",
    ),
    "CoachTurnTitle": MessageLookupByLibrary.simpleMessage(
      "Una posizione da rivedere",
    ),
    "CoachUnavailable": MessageLookupByLibrary.simpleMessage(
      "L’analisi non è disponibile al momento. Puoi comunque rivedere tutte le mosse.",
    ),
    "ComputerColor": m9,
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
    "DifficultyHard": MessageLookupByLibrary.simpleMessage("Difficile"),
    "DifficultyMedium": MessageLookupByLibrary.simpleMessage("Medio"),
    "DifficultySuperEasy": MessageLookupByLibrary.simpleMessage("Facilissimo"),
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
    "GameStatusAnnouncement": m10,
    "GamesPlayed": MessageLookupByLibrary.simpleMessage("Partite giocate"),
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
    "PlayerTurn": m11,
    "PracticeBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Scacchiera per allenare la strategia",
    ),
    "PracticeFlipped": m12,
    "PracticeInstructions": MessageLookupByLibrary.simpleMessage(
      "Gioca in una casella evidenziata e osserva cosa cambia.",
    ),
    "PracticeNoMoves": MessageLookupByLibrary.simpleMessage(
      "Questo colore non ha mosse consentite in questa posizione.",
    ),
    "PracticePlayed": m13,
    "PracticeReset": MessageLookupByLibrary.simpleMessage(
      "Prova un’altra mossa",
    ),
    "PracticeSafe": MessageLookupByLibrary.simpleMessage(
      "L’allenamento non influisce sulla partita salvata né sulle statistiche.",
    ),
    "PracticeTitle": MessageLookupByLibrary.simpleMessage(
      "Prova questa posizione",
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
      "Possiedi già Rimuovi annunci.",
    ),
    "PurchaseBenefitAds": MessageLookupByLibrary.simpleMessage(
      "Nessun banner né pubblicità al ritorno nell’app.",
    ),
    "PurchaseBenefitHints": MessageLookupByLibrary.simpleMessage(
      "Suggerimenti sulle mosse consentite a ogni livello contro il computer, senza guardare pubblicità.",
    ),
    "PurchaseBenefitOnce": MessageLookupByLibrary.simpleMessage(
      "Un solo pagamento. Nessun abbonamento. Ripristina con il tuo account App Store.",
    ),
    "PurchaseBenefitUndo": MessageLookupByLibrary.simpleMessage(
      "Annulla una volta per turno al livello Difficile senza guardare pubblicità.",
    ),
    "PurchaseBenefits": MessageLookupByLibrary.simpleMessage(
      "Un acquisto una tantum rimuove i banner e la pubblicità al ritorno nell’app e sblocca l’annullamento al livello Difficile e i suggerimenti sulle mosse consentite senza pubblicità premio. Ripristinalo sui dispositivi che usano lo stesso account App Store.",
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
      "Gli annunci sono stati rimossi. Grazie!",
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
    "PuzzleCornerObjective": m14,
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
    "PuzzleEndgameObjective": m15,
    "PuzzleEndgameSkill": MessageLookupByLibrary.simpleMessage(
      "Concludi con una vittoria",
    ),
    "PuzzleEndgameSuccess": MessageLookupByLibrary.simpleMessage(
      "Finale vinto. Le tue scelte hanno retto alle migliori risposte.",
    ),
    "PuzzleEndgameTryAgain": MessageLookupByLibrary.simpleMessage(
      "Questa linea non garantisce la vittoria contro il gioco migliore. Ricomincia e confronta un’altra mossa.",
    ),
    "PuzzleHint": m16,
    "PuzzleHintCoordinate": m17,
    "PuzzleNext": MessageLookupByLibrary.simpleMessage("Esercizio successivo"),
    "PuzzleNoResults": MessageLookupByLibrary.simpleMessage(
      "Nessun esercizio corrispondente. Prova un’abilità o il numero dell’esercizio.",
    ),
    "PuzzleNumber": m18,
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
    "PuzzlePassObjective": m19,
    "PuzzlePassSkill": MessageLookupByLibrary.simpleMessage(
      "Guadagna un altro turno",
    ),
    "PuzzlePassSuccess": MessageLookupByLibrary.simpleMessage(
      "Hai guadagnato un altro turno. L’avversario non ha mosse consentite e la partita continua.",
    ),
    "PuzzleProgress": m20,
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
    "RemoveAds": MessageLookupByLibrary.simpleMessage("Rimuovi annunci"),
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
    "ResultCardPreviewLabel": m21,
    "ResultCardShareFailed": MessageLookupByLibrary.simpleMessage(
      "La condivisione non è disponibile al momento. Riprova.",
    ),
    "ResultCardTitle": MessageLookupByLibrary.simpleMessage(
      "Condividi il risultato",
    ),
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Scacchiera di revisione della partita",
    ),
    "ReviewCorners": m22,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("Posizione finale"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("Vai all’inizio"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("Rivedi la partita"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("Vai alla fine"),
    "ReviewMove": m23,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("Mossa successiva"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage("Mossa precedente"),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("Posizione iniziale"),
    "Rules": MessageLookupByLibrary.simpleMessage("Regole"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "La tua scacchiera ti aspetta.",
    ),
    "SavedMatchScore": m24,
    "Settings": MessageLookupByLibrary.simpleMessage("Impostazioni"),
    "Share": MessageLookupByLibrary.simpleMessage("Condividi"),
    "ShareResult": m25,
    "Sound": MessageLookupByLibrary.simpleMessage("Suoni"),
    "StartGame": MessageLookupByLibrary.simpleMessage("Inizia partita"),
    "StartNewGame": MessageLookupByLibrary.simpleMessage(
      "Inizia una nuova partita",
    ),
    "Stats": MessageLookupByLibrary.simpleMessage("Statistiche"),
    "Theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "ThemeClassic": MessageLookupByLibrary.simpleMessage("Classico"),
    "ThemeContrast": MessageLookupByLibrary.simpleMessage("Contrasto"),
    "ThemeNight": MessageLookupByLibrary.simpleMessage("Notte"),
    "Tie": MessageLookupByLibrary.simpleMessage("Pareggio"),
    "Ties": MessageLookupByLibrary.simpleMessage("Pareggi"),
    "TryAgain": MessageLookupByLibrary.simpleMessage("Riprova"),
    "TurnPassed": m26,
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
    "TutorialProgress": m27,
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
    "UndoWithAd": MessageLookupByLibrary.simpleMessage(
      "Annulla · guarda un annuncio",
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
    "WinsLosses": m28,
    "YouColor": m29,
    "YouLose": MessageLookupByLibrary.simpleMessage("Hai perso"),
    "YouWin": MessageLookupByLibrary.simpleMessage("Hai vinto!"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("Tocca a te"),
  };
}
