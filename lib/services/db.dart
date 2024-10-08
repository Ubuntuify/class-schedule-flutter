import 'dart:developer' as dev;

import 'package:path/path.dart';
import 'package:schedule/schema/subject.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  // 🔗 Singleton pattern, there should only be one DatabaseManager in existence to prevent race conditions.
  static final DatabaseManager _databaseManager = DatabaseManager._internal();

  factory DatabaseManager() => _databaseManager;

  DatabaseManager._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // 🛠️ Internal functions used for backend database management.
  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'app.db');
    dev.log('Initializing database at $path');

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // TODO: finalize database implementation

    db.execute('''
    CREATE TABLE subject ( 
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      name TEXT, 
      is_visible INTEGER, 
      is_rest_period INTEGER
    );
    ''');
  }

  // ✨ Subjects Table
  Future<List<Subject>> getSubjects() async {
    final db = await _databaseManager.database;

    final List<Map<String, Object?>> subjects = await db.query('subject');

    return [
      for (final {
            'id': id as int,
            'name': name as String,
            'is_visible': isVisible as bool,
            'is_rest_period': isRestPeriod as bool,
          } in subjects)
        Subject(
            id: id,
            name: name,
            isVisible: isVisible,
            isRestPeriod: isRestPeriod),
    ];
  }

  Future<void> insertSubject(Subject subject) async {
    final db = await _databaseManager.database;
    await db.insert('subject', subject.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
