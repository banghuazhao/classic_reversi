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

  static String m0(coordinate, piece) => "${coordinate}, ${piece}";

  static String m1(color) => "Computer · ${color}";

  static String m2(status, black, white) =>
      "${status}. Nero ${black}, bianco ${white}.";

  static String m3(color) => "Tocca al ${color}";

  static String m4(black, white) => "Angoli · Nero ${black} · Bianco ${white}";

  static String m5(move, total) => "Mossa ${move} di ${total}";

  static String m6(result, black, white, mode) =>
      "${result} · Nero ${black} – Bianco ${white} (${mode}) — Classic Reversi";

  static String m7(passed, current) =>
      "Nessuna mossa valida per ${passed}. Muove ancora ${current}.";

  static String m8(step, total) => "Lezione ${step} di ${total}";

  static String m9(wins, losses) => "Vittorie ${wins} · Sconfitte ${losses}";

  static String m10(color) => "Tu · ${color}";

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
    "AchievementUnlocked": MessageLookupByLibrary.simpleMessage(
      "Obiettivo sbloccato",
    ),
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
    "BoardCell": m0,
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
    "ComputerColor": m1,
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
    "GameSetup": MessageLookupByLibrary.simpleMessage("Imposta la partita"),
    "GameStatusAnnouncement": m2,
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
    "More": MessageLookupByLibrary.simpleMessage("Altro"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("Altre App"),
    "NewGame": MessageLookupByLibrary.simpleMessage("Nuova partita"),
    "OK": MessageLookupByLibrary.simpleMessage("OK"),
    "Opponent": MessageLookupByLibrary.simpleMessage("Avversario"),
    "PerfectWins": MessageLookupByLibrary.simpleMessage("Vittorie perfette"),
    "Play": MessageLookupByLibrary.simpleMessage("Gioca"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage(
      "Gioca con un amico su questo dispositivo",
    ),
    "PlayerTurn": m3,
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
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Scacchiera di revisione della partita",
    ),
    "ReviewCorners": m4,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("Posizione finale"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("Vai all’inizio"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("Rivedi la partita"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("Vai alla fine"),
    "ReviewMove": m5,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("Mossa successiva"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage("Mossa precedente"),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("Posizione iniziale"),
    "Rules": MessageLookupByLibrary.simpleMessage("Regole"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "La tua scacchiera ti aspetta.",
    ),
    "Settings": MessageLookupByLibrary.simpleMessage("Impostazioni"),
    "Share": MessageLookupByLibrary.simpleMessage("Condividi"),
    "ShareResult": m6,
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
    "TurnPassed": m7,
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
    "TutorialProgress": m8,
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
    "WinsLosses": m9,
    "YouColor": m10,
    "YouLose": MessageLookupByLibrary.simpleMessage("Hai perso"),
    "YouWin": MessageLookupByLibrary.simpleMessage("Hai vinto!"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("Tocca a te"),
  };
}
