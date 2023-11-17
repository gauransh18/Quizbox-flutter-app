// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:quizbox/routes/routes.dart';
import 'package:quizbox/utils/buttons.dart';
import 'package:quizbox/utils/typography.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String user_name = "User"; //link to database

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final box = Hive.box('db');
    final savedUserName = box.get('user_name');
    setState(() {
      user_name = savedUserName ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 17, 17),
      body: Stack(
        children: [
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: GridPaper(
              color: Color.fromARGB(255, 89, 89, 89),
              interval: 125,
              subdivisions: 1,
              divisions: 1,
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                  child: typoL("QuizBox"),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: typoH("Welcome")),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: typoC(
                              "Hi $user_name! Get ready for the Ultimate Quiz Challenge. Click below to continue your journey of knowledge and fun!",
                              22,
                              "Sanchez",
                              const Color.fromARGB(255, 237, 237, 237),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                            ),
                            child: getNeoPopButton(
                              "Continue",
                              const Color.fromARGB(255, 237, 237, 237),
                              Colors.black,
                              categoryRoute,
                              context,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
