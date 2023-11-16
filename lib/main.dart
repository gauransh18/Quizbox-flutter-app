import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quizbox/routes/routes.dart';
import 'package:quizbox/screens/startup.dart';
import 'package:quizbox/screens/welcome.dart';
import 'package:quizbox/screens/category.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        welcomeRoute: (context) => const Welcome(),
        categoryRoute: (context) => const CategorySelection(),
       
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Startup(),
    );
  }
}
