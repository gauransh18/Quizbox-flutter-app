// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quizbox/routes/routes.dart';
import 'package:quizbox/utils/buttons.dart';
import 'package:quizbox/utils/typography.dart';

class CategorySelection extends StatefulWidget {
  const CategorySelection({super.key});

  @override
  State<CategorySelection> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  String user_name = "User"; //link to database
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white70,
        backgroundColor: Colors.transparent,
      ),
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                      child: typoL("QuizBox"),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, top: 12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white70,
                            width: 1,
                          
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0, left: 12.0),
                          child: typoC(user_name,
                              18, "Open Sans", Colors.white70),
                        )
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 60),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: typoC2(
                                "Select a\nCategory",
                                60,
                                "Sanchez",
                                Color.fromARGB(255, 227, 226, 226),
                                TextAlign.left),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                ),
                                child: getNeoPopButton(
                                  "Continue",
                                  Color.fromARGB(255, 227, 226, 226),
                                  Colors.black,
                                  categoryRoute,
                                  context,
                                )),
                                SizedBox(height: 20),
                                Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                ),
                                child: getNeoPopButton(
                                  "Continue",
                                  Color.fromARGB(255, 227, 226, 226),
                                  Colors.black,
                                  categoryRoute,
                                  context,
                                )),
                                SizedBox(height: 20),
                                Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                ),
                                child: getNeoPopButton(
                                  "Continue",
                                  Color.fromARGB(255, 227, 226, 226),
                                  Colors.black,
                                  categoryRoute,
                                  context,
                                )),
                                SizedBox(height: 20),
                                Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                ),
                                child: getNeoPopButton(
                                  "Continue",
                                  Color.fromARGB(255, 227, 226, 226),
                                  Colors.black,
                                  categoryRoute,
                                  context,
                                )),
                          ],
                        ),
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
