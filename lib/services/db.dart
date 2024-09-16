import 'dart:developer' as dev;

import 'package:path/path.dart';
import 'package:schedule/schema/subject.dart';
import 'package:schedule/utility/utility.dart';
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

    // ✨
    // Create 'subject' table, implementation located in lib/schema/subject.dart
    db.execute('''
    CREATE TABLE subject ( 
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      name TEXT, 
      description TEXT,
      location TEXT,
      is_visible INTEGER, 
      is_rest_period INTEGER
    );
    ''');

    // ✨
    // Create 'day_schedule' table, implementation located in
    // lib/schema/day_schedule
    db.execute('''
    CREATE TABLE day_schedule (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      weekday INTEGER,
      is_special INTEGER
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
            'description': description as String,
            'location': location as String,
            'is_visible': isVisible as int,
            'is_rest_period': isRestPeriod as int,
          } in subjects)
        Subject(
            id: id,
            name: name,
            description: description,
            location: location,
            isVisible: intToBool(isVisible),
            isRestPeriod: intToBool(isRestPeriod)),
    ];
  }

  Future<void> insertSubject(Subject subject) async {
    final db = await _databaseManager.database;
    await db.insert('subject', subject.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
