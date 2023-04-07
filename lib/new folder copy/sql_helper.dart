import 'package:sqflite/sqflite.dart';

class SqlHelper {
  static Future<void> createTable(Database database) async {
    await database.execute(""" CREATE TABLE items (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      description TEXT,
      cretaedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMPSTAMP,
    ) 
    """);
  }
}
