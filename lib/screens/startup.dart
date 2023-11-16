// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quizbox/routes/routes.dart';
import 'package:quizbox/utils/buttons.dart';
import 'package:quizbox/utils/typography.dart';

class Startup extends StatefulWidget {
  const Startup({super.key});

  @override
  State<Startup> createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  final TextEditingController _nameController = TextEditingController();
  String user_name = "User"; //link to database
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                typoL("QuizBox"),
                Spacer(),
                typoC(
                  "Welcome",
                  55,
                  "Sanchez",
                  Colors.white70,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 209, 209, 209),
                            filled: true,
                            labelText: "Enter your name",
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 11, 9, 9)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: const TextStyle(color: Color.fromARGB(255, 11, 9, 9)),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      getNeoPopButtonF(
                        "",
                        Color.fromARGB(255, 209, 209, 209),
                        Colors.black,
                        welcomeRoute,
                        context,
                        (){
                          user_name = _nameController.text;
                          // print(user_name);
                        }
                      ),
                    ],
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
