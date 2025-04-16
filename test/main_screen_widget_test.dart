import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_notion/models/categories.dart';
import 'package:mini_notion/models/entry_model.dart';
import 'package:mini_notion/providers/categories_provider.dart';
import 'package:mini_notion/providers/entry_provider.dart';
import 'package:mini_notion/providers/new_entry_form_provider.dart';
import 'package:mini_notion/screens/main_screen.dart';
import 'package:mini_notion/screens/new_entry_screen.dart';
import 'package:mini_notion/services/sql_helper.dart';
import 'package:mini_notion/widgets/entry_item.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Main screen widget should', () {
    final fakeEntries = [
      Entry(Uuid().v4(), 'Prueba 1', 'aaaaaaa', [CategoriesEnum.IDIA], DateTime.now().toIso8601String()),
      Entry(Uuid().v4(), 'Prueba 2', 'bbbbbbb', [CategoriesEnum.PROJECT], DateTime.now().toIso8601String()),
      Entry(Uuid().v4(), 'Prueba 3', 'ccccccc', [CategoriesEnum.NOTE], DateTime.now().toIso8601String())
    ];

    late FormEntryProvider formEntryProvider;
    late EntryProvider entryProvider;
    late CategoriesProvider categoriesProvider;
    late Database db;

    setUp(() async {
      formEntryProvider = FormEntryProvider();
      entryProvider = EntryProvider();
      categoriesProvider = CategoriesProvider();

      db = await databaseFactory.openDatabase(inMemoryDatabasePath, options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) async {
            await SqlHelper.instance.onCreate(db, version);
          }
      ));

      SqlHelper.injectTestDatabase(db);
    });

    setUpAll(() {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    tearDown(() async {
      await db.close();
    });

    Widget buildTestableWidget() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<FormEntryProvider>.value(value: formEntryProvider,),
          ChangeNotifierProvider<EntryProvider>.value(value: entryProvider,),
          ChangeNotifierProvider<CategoriesProvider>.value(value: categoriesProvider,)
        ],
        child: const MaterialApp(
            home: MainScreen()
        ),
      );
    }

    testWidgets('Check if render all elements in the screen', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      expect(find.text('Mini Notion'), findsOne);
      expect(find.byIcon(Icons.add), findsOne);
      expect(find.byType(FloatingActionButton), findsOne);
      expect(find.byType(EntryItem), findsNothing);
    });

    /*testWidgets('Check the title of all list elements', (tester) async {
      entryProvider.addEntry(fakeEntries[0]);
      entryProvider.addEntry(fakeEntries[1]);
      entryProvider.addEntry(fakeEntries[2]);

      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Prueba 1'), findsOneWidget);
      expect(find.text('Prueba 2'), findsOneWidget);
      expect(find.text('Prueba 3'), findsOneWidget);
    });*/

    testWidgets('Navigate to "Entry Screen" when press the FAB', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(NewEntryScreen), findsOneWidget);
    });
  });
}