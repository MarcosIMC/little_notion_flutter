import 'package:flutter_test/flutter_test.dart';
import 'package:mini_notion/services/sql_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('Database should', () {
    late SqlHelper db;

    setUp(() {
      db = SqlHelper.instance;
      databaseFactory = databaseFactoryFfi;
    });

    test('Check if the DB is not null', () {
      expect(db.database, isNotNull);
    });
  });
}