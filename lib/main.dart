import 'package:flutter/material.dart';
import 'package:todo/pages/home_page.dart';
import 'database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final AppDatabase? database;

  const MyApp({Key? key, this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(database: database),
    );
  }
}
