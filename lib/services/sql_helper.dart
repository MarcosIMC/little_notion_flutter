import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/entry_model.dart';

class SqlHelper {
  static final SqlHelper instance = SqlHelper._init();

  SqlHelper._init();

  static Database? _database;

  static Database? _externalTestDB;

  static void injectTestDatabase(Database db) {
    _externalTestDB = db;
    _database = db;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notion.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE tasks (id TEXT PRIMARY KEY NOT NULL, title TEXT, description TEXT, categories TEXT, date TEXT)'''
    );
  }

  Future<int?> insertEntry(Entry entry) async {
    final db = await database;
    return await db.insert('tasks', entry.toMap());
  }

  Future<List<Entry>> getAll() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('tasks');

    return result.map((map) => Entry.fromMap(map)).toList();
  }
}