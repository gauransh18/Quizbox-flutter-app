import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quizbox/routes/routes.dart';
import 'package:quizbox/utils/buttons.dart';
import 'package:quizbox/utils/typography.dart';
import 'package:confetti/confetti.dart';

class QuizScore extends StatefulWidget {
  final Object arguments;
  const QuizScore({Key? key, required this.arguments}) : super(key: key);

  @override
  State<QuizScore> createState() => _QuizScoreState();
}

class _QuizScoreState extends State<QuizScore> {
  double percentage = 0.0;
  String user_name = "User";

  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 5));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null) {
      percentage = args as double;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _confettiController.play(); // Play confetti when the widget is initialized
  }

  Future<void> _loadUserName() async {
    print(percentage.toString());
    final box = Hive.box('db');
    final savedUserName = box.get('user_name');
    setState(() {
      user_name = savedUserName ?? "User";
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
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
                          padding:
                              const EdgeInsets.only(right: 12.0, left: 12.0),
                          child:
                              typoC(user_name, 18, "Open Sans", Colors.white70),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: typoH("Your Score"),
                ),
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
                              'You scored ${percentage.toStringAsFixed(2)}%',
                              22,
                              'Sanchez',
                              Color.fromRGBO(255, 235, 52, 1),
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
                            'Back to Home',
                            const Color.fromARGB(255, 237, 237, 237),
                            Colors.black,
                            welcomeRoute,
                            context,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (percentage >= 100)
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ],
              ),
            ),
        ],
      ),
    );
  }
}
