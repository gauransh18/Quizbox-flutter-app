import 'package:flutter/material.dart';
import 'package:quizbox/routes/routes.dart';
import 'package:quizbox/screens/quiz.dart';
import 'package:quizbox/screens/score.dart';
import 'package:quizbox/screens/startup.dart';
import 'package:quizbox/screens/welcome.dart';
import 'package:quizbox/screens/category.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("db");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizBox',
      debugShowCheckedModeBanner: false,
      routes: {
        welcomeRoute: (context) => const Welcome(),
        categoryRoute: (context) => const CategorySelection(),
        sportsQuizRoute: (context) => const QuizSports(),
        spaceQuizRoute: (context) => const QuizSpace(),
        movieQuizRoute: (context) => const QuizMovie(),
        codingQuizRoute: (context) => const QuizCoding(),
        scoreRoute: (context) => QuizScore(arguments: double),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Startup(),
    );
  }
}
