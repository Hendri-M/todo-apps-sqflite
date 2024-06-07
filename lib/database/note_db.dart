import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_apps/models/notes.dart';

class NotesDB {
  NotesDB._init();

  static final instance = NotesDB._init();
  static Database? _database;

  // Singleton
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB('note.db');
    return _database;
  }

  // Create DB
  Future<Database?> _initDB(String pathDB) async {
    final pathDatabase = await getDatabasesPath();
    final path = join(pathDatabase, pathDB);

    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    return db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        priority TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
      ''');
  }

  // CRUD Functions
  Future<Notes> create(Notes note) async {
    final db = await instance.database;
    final data = await db!.insert('notes', note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return note.copy(id: data);
  }

  Future<int> update(Notes note) async {
    final db = await instance.database;
    final data = await db!.update('notes', note.toJson(),
        where: "id = ?",
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);

    return data;
  }

  Future<List<Notes>> readAllNotes() async {
    final db = await instance.database;
    final data = await db!.query('notes', orderBy: 'id');

    return data.map((json) => Notes.fromJson(json)).toList();
  }

  Future<List<Notes>> readNotesByName(String title) async {
    final db = await instance.database;
    final data =
        await db!.query('notes', where: "title = ?", whereArgs: [title]);

    if (data.isNotEmpty) {
      return data.map((json) => Notes.fromJson(json)).toList();
    } else {
      throw Exception('Error getting Notes at id: $title');
    }
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    final data = await db!.delete('notes', where: "id = ?", whereArgs: [id]);

    return data;
  }

  // Close DB
  Future close() async {
    final db = await instance.database;

    return db!.close();
  }
}
