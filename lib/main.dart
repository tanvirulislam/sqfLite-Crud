import 'package:flutter/material.dart';
import 'package:sqflite_crud/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        iconTheme: IconThemeData(color: Colors.purple),
      ),
      darkTheme: ThemeData.dark(),
      home: Home(),
    );
  }
}
