import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_crud/db_helper.dart';
import 'package:sqflite_crud/model/profile.dart';

final databaseProvider = FutureProvider<Database>((ref) async {
  return await LocalDb().initDatabase();
});

final dataProvider = StreamProvider<List<ProfileModel>>(
  (ref) {
    final database = ref.watch(databaseProvider);
    return database.maybeWhen(
      data: (db) {
        return db.query('your_table_name').asStream().map(
              (e) => e.map((event) => ProfileModel.fromMap(event)).toList(),
            );
      },
      orElse: () {
        return Stream<List<ProfileModel>>.empty();
      },
    );
  },
);
