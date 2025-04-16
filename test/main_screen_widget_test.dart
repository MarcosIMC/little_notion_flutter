import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_notion/models/categories.dart';
import 'package:mini_notion/models/entry_model.dart';
import 'package:mini_notion/screens/main_screen.dart';
import 'package:mini_notion/screens/new_entry_screen.dart';
import 'package:mini_notion/widgets/entry_item.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Main screen widget should', () {
    final fakeEntries = [
      Entry(Uuid().v4(), 'Prueba 1', 'aaaaaaa', [CategoriesEnum.IDIA], DateTime.now()),
      Entry(Uuid().v4(), 'Prueba 2', 'bbbbbbb', [CategoriesEnum.PROJECT], DateTime.now()),
      Entry(Uuid().v4(), 'Prueba 3', 'ccccccc', [CategoriesEnum.NOTE], DateTime.now())
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

    testWidgets('Navigate to "Entry Screen" when press the FAB', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(NewEntryScreen), findsOneWidget);
    });
  });
}