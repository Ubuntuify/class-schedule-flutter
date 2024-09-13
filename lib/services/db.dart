import 'package:path/path.dart';
import 'package:schedule/schema/schedule.dart';
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

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // TODO: finalize database implementation

    // await db.execute(
    //     'CREATE TABLE class (id INTEGER PRIMARY KEY, name TEXT, is_visible INTEGER, is_rest_period INTEGER)');
    //
    // await db.execute(
    //     'CREATE TABLE day_schedule (id INTEGER PRIMARY KEY, weekday INTEGER, is_special INTEGER)');
    //
    // await db.execute(
    //     'CREATE TABLE schedule_time_slot (id INTEGER PRIMARY KEY, day_schedule_id INTEGER, FOREIGN KEY (day_schedule_id) REFERENCES day_schedule (id) ON DELETE CASCADE ON UPDATE NO ACTION, starthour INTEGER, startminute INTEGER, endhour INTEGER, endminute INTEGER)');
    //
    // await db.execute(
    //     'CREATE TABLE class_time (id INTEGER PRIMARY KEY, day_schedule_id INTEGER, FOREIGN KEY (day_schedule_id) REFERENCES day_schedule (id) ON DELETE CASCADE ON UPDATE NO ACTION, class_id INTEGER, FOREIGN KEY (class_id) REFERENCES class (id) ON DELETE CASCADEON UPDATE NO ACTION, schedule_time_slot_id INTEGER, FOREIGN KEY (schedule_time_slot_id) REFERENCES schedule_time_slot (id) ON DELETE CASCADE ON UPDATE NO ACTION)');
  }

  // ✨ Subjects Table
  Future<List<Subject>> getSubjects() async {
    final db = await database;

    final List<Map<String, Object?>> subjects = await db.query('subjects');

    return [
      for (final {
            'id': id as int,
            'name': name as String,
            'is_visible': isVisible as bool,
            'is_rest_period': isRestPriod as bool,
          } in subjects)
        Subject(
            id: id,
            name: name,
            isVisible: isVisible,
            isRestPeriod: isRestPriod),
    ];
  }
}
