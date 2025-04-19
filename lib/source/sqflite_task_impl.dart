import 'package:mdata_base/model/model.dart';
import 'package:mdata_base/source/source_abs.dart';

import 'package:mdata_base/model/model.dart';
import 'package:mdata_base/source/source_abs.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteTaskImpl implements DataSource<Task> {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks_database.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks(id TEXT PRIMARY KEY, title TEXT, description TEXT)",
        );
      },
      version: 1,
    );
  }

  @override
  Future<void> add(Task data) async {
    final db = await database;
    await db.insert(
      'tasks',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> delete(Task data) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: "id = ?",
      whereArgs: [data.id],
    );
  }

  @override
  Future<void> deleteAll() async {
    final db = await database;
    await db.delete('tasks');
  }

  @override
  Future<void> deleteById(String id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<Task?> findById(String id) async {
    final db = await database;
    final maps = await db.query(
      'tasks',
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Task.fromMap(maps.first);
    }
    return null;
  }

  @override
  Task? findByIndex(int index) {
    // This method is not applicable for sqflite, consider removing it from the interface
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAll() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  @override
  Future<List<Task>> getAllByKeyword(String keyword) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: "title LIKE ? OR description LIKE ?",
      whereArgs: ['%$keyword%', '%$keyword%'],
    );

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  @override
  Future<bool> isEmpty() async {
    final db = await database;
    final count =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM tasks'));
    return count == 0;
  }

  @override
  Future<void> update(Task data) async {
    final db = await database;
    await db.update(
      'tasks',
      data.toMap(),
      where: "id = ?",
      whereArgs: [data.id],
    );
  }

  @override
  Future<void> updateByIndex(int index, Task data) {
    // This method is not applicable for sqflite, consider removing it from the interface
    throw UnimplementedError();
  }
}
