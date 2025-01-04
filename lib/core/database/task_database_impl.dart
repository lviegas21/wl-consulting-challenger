import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/datasources/datasources.dart';
import '../../data/models/models.dart';
import '../../domain/entities/entities.dart';

class TaskDatabaseImpl implements TaskDatabase {
  static final TaskDatabaseImpl _instance = TaskDatabaseImpl._init();
  static Database? _database;

  TaskDatabaseImpl._init();

  factory TaskDatabaseImpl() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
      CREATE TABLE tasks (
        id $idType,
        title $textType,
        description $textType,
        isCompleted $boolType
      )
    ''');
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    final db = await database;

    await db.insert(
      'tasks',
      converterEntity(task).toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  TaskModel converterEntity(task) => TaskModel.fromEntity(task);

  @override
  Future<List<TaskEntity>> getAllTasks() async {
    final db = await database;

    final maps = await db.query('tasks', orderBy: 'id ASC');

    if (maps.isNotEmpty) {
      return maps.map((task) => TaskModel.fromJson(task).toEntity()).toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    final db = await database;

    await db.update(
      'tasks',
      converterEntity(task).toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  @override
  Future<void> deleteTask(int id) async {
    final db = await database;

    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
