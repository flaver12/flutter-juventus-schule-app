import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/bmi.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'bmi_database.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE bmi(id INTEGER PRIMARY KEY, value REAL)',
        );
      },
      version: 1,
    );
  }

  Future<void> saveBmi(Bmi bmi) async {
    final db = await database;
    await db.insert(
      'bmi',
      bmi.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Bmi>> loadBmis() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('bmi');

    return List.generate(maps.length, (i) {
      return Bmi(
        id: maps[i]['id'],
        value: maps[i]['value'],
      );
    });
  }
}