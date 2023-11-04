import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_crud/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'sqflite',
        theme: ThemeData(primarySwatch: Colors.lightBlue),
        // themeMode: ThemeMode.system,
        // darkTheme: ThemeData.dark(),
        home: Home(),
      ),
    );
  }
}
