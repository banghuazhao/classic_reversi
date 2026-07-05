import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:classic_reversi/main.dart';

void main() {
  testWidgets('start screen leads into a playable game', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Classic Reversi'), findsOneWidget);
    expect(find.text('Start Game'), findsOneWidget);

    await tester.tap(find.text('Easy'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Start Game'));
    await tester.pumpAndSettle();

    // The board should now be showing with the standard starting scores.
    expect(find.text('black'), findsOneWidget);
    expect(find.text('white'), findsOneWidget);
    expect(find.text('2'), findsNWidgets(2));

    // Tap a legal opening move for black. GestureDetectors are: the restart
    // button, the help button, then the 64 board squares in row-major order.
    // Index 2 + (2*8+4) = 22 is board square (x=4, y=2), a legal opening move.
    final gestureDetectors = find.byType(GestureDetector);
    expect(gestureDetectors, findsNWidgets(66));
    await tester.tap(gestureDetectors.at(22));

    // Let the move resolve and the CPU (which also moves as part of this
    // flow) respond after its "thinking" delay.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();

    // Both scores should have moved off the starting 2-2 split, confirming
    // the tap was registered as a legal move and the game actually advanced.
    expect(find.text('2'), findsNothing);
  });
}
