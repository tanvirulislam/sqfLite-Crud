import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_crud/model/notes.dart';

class DatabaseHelper {
  static final _databaseName = "note.db";
  static final _databaseVersion = 1;
  static final table = "notes";
  static Database? _database;

  Future<Database?> get getDatabase async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(""" CREATE TABLE $table(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      age INTEGER NOT NULL,
      description TEXT NOT NULL,
      email TEXT NOT NULL,
      address TEXT NOT NULL
    )""");
  }

  Future<NoteModel> insert(NoteModel model) async {
    var dbClint = await getDatabase;
    await dbClint!.insert(table, model.toMap());
    return model;
  }

  Future<List<NoteModel>> getNoteList() async {
    var dbClint = await getDatabase;
    final queryResult = await dbClint!.query(table);
    return queryResult.map((e) => NoteModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClint = await getDatabase;
    return await dbClint!.delete(
      table,
      where: 'id=?',
      whereArgs: [id],
    );
  }

  update(NoteModel model) async {
    var dbClint = await getDatabase;
    return await dbClint!.update(
      table,
      model.toMap(),
      where: 'id=?',
      whereArgs: [model.id],
    );
  }
}
