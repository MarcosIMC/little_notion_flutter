import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_notion/screens/main_screen.dart';

void main() {
  group('Main screen widget should', () {
    Widget buildTestableWidget() {
      return const MaterialApp(
        home: MainScreen(),
      );
    }

    testWidgets('Check if render all elements in the screen', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      expect(find.text('Mini Notion'), findsOne);
      expect(find.byIcon(Icons.add), findsOne);
      expect(find.byType(FloatingActionButton), findsOne);
    });
  });
}