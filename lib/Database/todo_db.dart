import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const String sql =
        'CREATE TABLE todoTable (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,date TEXT NOT NULL, isComplete INTEGER NOT NULL)';
    await db.execute(sql);
  }

  Future<int> addTask(String titl) async {
    final db = await instance.database;
    String date = DateTime.now().millisecondsSinceEpoch.toString();
    return await db.insert('todoTable', {
      'title': titl,
      'date': date,
      'isComplete': 0,
    });
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await instance.database;
    return await db.query('todoTable');
  }

  Future<int> markTaskDone(
    int id,
  ) async {
    final db = await instance.database;
    return await db.update('todoTable', {'isComplete': 1},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> editTask(int id, String title) async {
    log("$id$title");
    final db = await instance.database;
    return await db.update('todoTable', {'title': title},
        where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.delete('todoTable');
    db.close();
  }
}
