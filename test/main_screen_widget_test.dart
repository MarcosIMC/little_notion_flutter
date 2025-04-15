import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_notion/models/categories.dart';
import 'package:mini_notion/models/entry_model.dart';
import 'package:mini_notion/screens/main_screen.dart';
import 'package:mini_notion/widgets/entry_item.dart';

void main() {
  group('Main screen widget should', () {
    final fakeEntries = [
      Entry('Prueba 1', 'aaaaaaa', CategoriesEnum.IDIA),
      Entry('Prueba 2', 'bbbbbbb', CategoriesEnum.PROJECT),
      Entry('Prueba 3', 'ccccccc', CategoriesEnum.NOTE)
    ];

    Widget buildTestableWidget() {
      return MaterialApp(
        home: MainScreen(entries: fakeEntries),
      );
    }

    testWidgets('Check if render all elements in the screen', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      expect(find.text('Mini Notion'), findsOne);
      expect(find.byIcon(Icons.add), findsOne);
      expect(find.byType(FloatingActionButton), findsOne);
      expect(find.byType(EntryItem), findsWidgets);
    });

    testWidgets('Check the title of all list elements', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      expect(find.text('Prueba 1'), findsOneWidget);
      expect(find.text('Prueba 2'), findsOneWidget);
      expect(find.text('Prueba 3'), findsOneWidget);
    });
  });
}