import 'package:flutter/material.dart';
import 'package:masterclass_2/LocalDb.dart';
import 'package:masterclass_2/pages/home_page.dart';

void main() async
{
  // Ensure that the Flutter engine is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  final LocalDb db = LocalDb();
  await db.database;


  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}