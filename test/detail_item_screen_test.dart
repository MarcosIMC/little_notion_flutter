import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_notion/models/categories.dart';
import 'package:mini_notion/models/entry_model.dart';
import 'package:mini_notion/providers/categories_provider.dart';
import 'package:mini_notion/providers/entry_provider.dart';
import 'package:mini_notion/providers/new_entry_form_provider.dart';
import 'package:mini_notion/screens/detail_task_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Detail view screen should', () {
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
        child: MaterialApp(
            home: DetailTaskScreen(entry: Entry(Uuid().v4(), 'Prueba 1', 'aaaaaaa', [CategoriesEnum.IDIA], DateTime.now().toIso8601String()))
        ),
      );
    }
    
    testWidgets('Check if the screen render all elements', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      
      expect(find.text('Prueba 1'), findsOneWidget);
      expect(find.text('aaaaaaa'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });
  });
}