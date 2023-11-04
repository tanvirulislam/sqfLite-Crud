import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_crud/model/profile.dart';

class LocalDb {
  static final _databaseName = "profile.db";
  static final _databaseVersion = 1;
  static final table = "profile";
  static Database? _database;

  Future<Database?> get getDatabase async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
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

  Future<ProfileModel> insert(ProfileModel model) async {
    var dbClint = await getDatabase;
    await dbClint!.insert(table, model.toMap());
    return model;
  }

  Future<List<ProfileModel>> getNoteList() async {
    var dbClint = await getDatabase;
    final queryResult = await dbClint!.query(table);
    return queryResult.map((e) => ProfileModel.fromMap(e)).toList();
  }

  Future<int> delete(id) async {
    var dbClint = await getDatabase;
    return await dbClint!.delete(
      table,
      where: 'id=?',
      whereArgs: [id],
    );
  }

  update(ProfileModel model) async {
    var dbClint = await getDatabase;
    return await dbClint!.update(
      table,
      model.toMap(),
      where: 'id=?',
      whereArgs: [model.id],
    );
  }
}
