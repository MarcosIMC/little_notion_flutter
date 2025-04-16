import 'package:flutter_test/flutter_test.dart';
import 'package:mini_notion/models/entry_model.dart';
import 'package:mini_notion/services/sql_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Database should', () {
    late Database db;

    setUpAll(() {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    setUp(() async {
      db = await databaseFactory.openDatabase(inMemoryDatabasePath, options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) async {
            await SqlHelper.instance.onCreate(db, version);
          }
      ));

      SqlHelper.injectTestDatabase(db);
    });

    tearDown(() async {
      await db.close();
    });

    test('Check if the DB is not null', () {
      expect(db.database, isNotNull);
    });
    
    test('Insert a new entry', () async {
      var rowId = await SqlHelper.instance.insertEntry(Entry(Uuid().v4(), 'Test', 'Test description', [], DateTime.now().toIso8601String()));
      expect(rowId, 1);
    });

    test('Select all entries on DB', () async {
      await SqlHelper.instance.insertEntry(Entry(Uuid().v4(), 'Test', 'Test description', [], DateTime.now().toIso8601String()));
      List<Entry> entries = await SqlHelper.instance.getAll();
      expect(entries.length, equals(1));
    });
  });
}