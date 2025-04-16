import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_notion/providers/categories_provider.dart';
import 'package:mini_notion/providers/entry_provider.dart';
import 'package:mini_notion/providers/new_entry_form_provider.dart';
import 'package:mini_notion/screens/new_entry_screen.dart';
import 'package:mini_notion/widgets/filter_chip.dart';
import 'package:provider/provider.dart';

void main() {
  group('New Entry screen should', () {
    late FormEntryProvider formEntryProvider;
    late EntryProvider entryProvider;
    late CategoriesProvider categoriesProvider;

    setUp(() {
      formEntryProvider = FormEntryProvider();
      entryProvider = EntryProvider();
      categoriesProvider = CategoriesProvider();
    });

    Widget buildTestableWidget() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<FormEntryProvider>.value(value: formEntryProvider,),
          ChangeNotifierProvider<EntryProvider>.value(value: entryProvider,),
          ChangeNotifierProvider<CategoriesProvider>.value(value: categoriesProvider,)
        ],
        child: const MaterialApp(
            home: NewEntryScreen()
        ),
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
    
    testWidgets('Check if show the validator message on "title" and "description"', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      
      expect(find.text('Please, type a title for a new entry.'), findsOneWidget);
      expect(find.text('Please, type a task description.'), findsOneWidget);
    });
  });
}