import 'package:flutter/material.dart';
import 'package:masterclass_2/LocalDb.dart';
import 'package:masterclass_2/pages/home_page.dart';

void main() async
{
  // Ensure that the Flutter engine is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  final localDb = LocalDb();
  await localDb.database;
  runApp(MyApp(db: localDb));
}

class MyApp extends StatelessWidget {
  final LocalDb db;
  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(db : db),
    );
  }
}