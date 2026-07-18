import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:classic_reversi/main.dart';

void main() {
  testWidgets('start screen leads into a playable game', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Classic Reversi'), findsOneWidget);
    expect(find.text('Start Game'), findsOneWidget);

    await tester.ensureVisible(find.text('Easy'));
    await tester.tap(find.text('Easy'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Start Game'));
    await tester.tap(find.text('Start Game'));
    await tester.pumpAndSettle();

    // The board should now be showing with the standard starting scores.
    expect(find.text('black'), findsOneWidget);
    expect(find.text('white'), findsOneWidget);
    expect(find.text('2'), findsNWidgets(2));

    // (4, 2) is a legal opening move for black.
    await tester.tap(find.byKey(const ValueKey('cell-4-2')));

    // Let the move resolve and the CPU (which also moves as part of this
    // flow) respond after its "thinking" delay.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();

    // Both scores should have moved off the starting 2-2 split, confirming
    // the tap was registered as a legal move and the game actually advanced.
    expect(find.text('2'), findsNothing);

    // Undo should take the board all the way back to the starting position
    // (it reverts to just before the human's move, undoing the CPU's
    // response along with it).
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();
    expect(find.text('2'), findsNWidgets(2));

    // Only one undo is allowed per turn: the button should now be disabled.
    final undoButton =
        tester.widget<ElevatedButton>(find.byType(ElevatedButton).first);
    expect(undoButton.onPressed, isNull);
  });
}
