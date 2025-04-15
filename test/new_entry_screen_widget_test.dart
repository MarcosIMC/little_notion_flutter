import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_notion/screens/new_entry_screen.dart';
import 'package:mini_notion/widgets/filter_chip.dart';

void main() {
  group('New Entry screen should', () {
    Widget buildTestableWidget() {
      return MaterialApp(
        home: NewEntryScreen(),
      );
    }

    testWidgets('Check if render all elements in the screen', (tester) async {
      await tester.pumpWidget(buildTestableWidget());

      expect(find.text('New Entry'), findsOne);
      expect(find.ancestor(of: find.text('Title...'), matching: find.byType(TextFormField)), findsOneWidget);
      expect(find.byType(FilterChipWidget), findsExactly(1));
      expect(find.ancestor(of: find.text('Type ur task...'), matching: find.byType(TextFormField)), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
    });
  });
}