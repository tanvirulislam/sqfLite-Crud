import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_crud/db_helper.dart';
import 'package:sqflite_crud/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DatabaseProvider(),
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
