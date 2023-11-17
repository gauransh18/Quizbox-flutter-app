// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quizbox/routes/routes.dart';
import 'package:quizbox/utils/buttons.dart';
import 'package:quizbox/utils/typography.dart';

//sports quiz
class QuizSports extends StatefulWidget {
  const QuizSports({super.key});

  @override
  State<QuizSports> createState() => _QuizSportsState();
}

class _QuizSportsState extends State<QuizSports> {
  String user_name = "User";
  String selectedOption = "";
  int currentQuestionIndex = 0;
  List<String> questions = [
    "Q. Which country won the FIFA World Cup in 2018?",
    "Q. In which sport is the term 'slam dunk' associated?",
    "Q. Who is often referred to as 'The GOAT' (Greatest of All Time) in tennis?",
    "Q. How many players are there in a standard soccer (football) team?",
    "Q. What is the national sport of Japan?"
  ];

  List<List<String>> optionsList = [
    ["France", "Brazil", "Germany", "Spain"],
    ["Football", "Basketball", "Tennis", "Golf"],
    ["Roger Federer", "Serena Williams", "Rafael Nadal", "Novak Djokovic"],
    ["10", "9", "11", "8"],
    ["Basketball", "Judo", "Karate", "Sumo Wrestling"]
  ];

  // Correct answers for each question
  List<String> correctAnswers = [
    "France",
    "Basketball",
    "Roger Federer",
    "11",
    "Sumo Wrestling"
  ];

  // User's score
  int userScore = 0;

  @override
  void initState() {
    super.initState();
    _loadUserName().then((_) {
      _resetQuizState();
      _storeQuestionAndOptions(currentQuestionIndex);
    });
  }

  Future<void> _storeQuestionAndOptions(int index) async {
    final box = Hive.box('db');
    final question = questions[index];
    final options = optionsList[index];
    await box.put('question', question);
    await box.put('options', options);
  }

  Future<String> _getQuestion() async {
    final box = Hive.box('db');
    final question = box.get('question');
    return question ?? "No question found";
  }

  Future<List<String>> _getOptions() async {
    final box = Hive.box('db');
    final options = box.get('options');
    return options ?? [];
  }

  Future<void> _loadUserName() async {
    final box = Hive.box('db');
    final savedUserName = box.get('user_name');
    setState(() {
      user_name = savedUserName ?? "User";
    });
  }

  void _handleRadioValueChange(String? value) {
    setState(() {
      selectedOption = value ?? "";
    });
  }

  Future<void> _loadNextQuestion() async {
    if (currentQuestionIndex < questions.length - 1) {

      if (selectedOption.trim().toLowerCase() ==
          correctAnswers[currentQuestionIndex].trim().toLowerCase()) {
        userScore++;
      }
      currentQuestionIndex++;
      await _storeQuestionAndOptions(
          currentQuestionIndex);
      setState(() {
        selectedOption = "";
      });
    } else {
      if (selectedOption.trim().toLowerCase() ==
          correctAnswers[currentQuestionIndex].trim().toLowerCase()) {
        userScore++;
      }
      setState(() {
        selectedOption = "";
        _submitAnswer(); 
        double percentage = (userScore / questions.length) * 100;
        print("Final Percentage: $percentage%");
        _resetQuizState(); 
        Navigator.of(context).pushNamedAndRemoveUntil(
        scoreRoute, (route) => false, arguments: percentage);
      });
    }
  }

  void _resetQuizState() {
    setState(() {
      selectedOption = "";
      currentQuestionIndex = 0;
      userScore = 0;
    });
  }

  void _submitAnswer() {
    // Check if the selected option is correct and update the score
    if (selectedOption.trim().toLowerCase() ==
        correctAnswers[currentQuestionIndex].trim().toLowerCase()) {
      userScore++;
    }
    print("Selected Option: $selectedOption");
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
                            child: typoC(
                                user_name, 18, "Open Sans", Colors.white70),
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: typoH("Sports"),
                ),
                SizedBox(height: 20),
                FutureBuilder<String>(
                  future: _getQuestion(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: typoC2(snapshot.data!, 22, "Sanchez",
                            Colors.white70, TextAlign.left),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                SizedBox(height: 20),
                FutureBuilder<List<String>>(
                  future: _getOptions(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final options = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final option in options)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, bottom: 12),
                              child: GestureDetector(
                                onTap: () {
                                  _handleRadioValueChange(option);
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 17, 17, 17),
                                    border: Border.all(
                                      color: Colors.white70,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 24.0,
                                          child: Radio(
                                            value: option,
                                            groupValue: selectedOption,
                                            onChanged: _handleRadioValueChange,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 8.0),
                                            child: typoC2(
                                              option,
                                              22,
                                              "Sanchez",
                                              Colors.white70,
                                              TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: 20),
                          Center(
                            child: getSubmitButton(context, () {
                              _loadNextQuestion();
                              _submitAnswer();
                            },
                                currentQuestionIndex < questions.length - 1
                                    ? "Next"
                                    : "Submit"),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}









//space quiz
class QuizSpace extends StatefulWidget {
  const QuizSpace({super.key});

  @override
  State<QuizSpace> createState() => _QuizSpaceState();
}

class _QuizSpaceState extends State<QuizSpace> {
  String user_name = "User";
  String selectedOption = "";
  int currentQuestionIndex = 0;
  List<String> questions = [
    "Q. Which planet is known as the 'Red Planet'?",
    "Q. What is the largest planet in our solar system?",
    "Q. Who was the first human to walk on the moon?",
    "Q. What is the name of the nearest galaxy to the Milky Way?",
    "Q. Which planet is known as the 'Morning Star' or 'Evening Star'?"
  ];

  List<List<String>> optionsList = [
    ["Mars", "Venus", "Jupiter", "Mercury"],
    ["Jupiter", "Saturn", "Neptune", "Earth"],
    ["Neil Armstrong", "Buzz Aldrin", "Yuri Gagarin", "Alan Shepard"],
    ["Andromeda", "Triangulum", "Orion", "Canis Major Dwarf"],
    ["Venus", "Mars", "Jupiter", "Saturn"]
  ];

  // Correct answers for each question
  List<String> correctAnswers = [
    "Mars",
    "Jupiter",
    "Neil Armstrong",
    "Andromeda",
    "Venus"
  ];

  // User's score
  int userScore = 0;

  @override
  void initState() {
    super.initState();
    _loadUserName().then((_) {
      _resetQuizState();
      _storeQuestionAndOptions(currentQuestionIndex);
    });
  }

  Future<void> _storeQuestionAndOptions(int index) async {
    final box = Hive.box('db');
    final question = questions[index];
    final options = optionsList[index];
    await box.put('question', question);
    await box.put('options', options);
  }

  Future<String> _getQuestion() async {
    final box = Hive.box('db');
    final question = box.get('question');
    return question ?? "No question found";
  }

  Future<List<String>> _getOptions() async {
    final box = Hive.box('db');
    final options = box.get('options');
    return options ?? [];
  }

  Future<void> _loadUserName() async {
    final box = Hive.box('db');
    final savedUserName = box.get('user_name');
    setState(() {
      user_name = savedUserName ?? "User";
    });
  }

  void _handleRadioValueChange(String? value) {
    setState(() {
      selectedOption = value ?? "";
    });
  }

  Future<void> _loadNextQuestion() async {
    if (currentQuestionIndex < questions.length - 1) {
      if (selectedOption.trim().toLowerCase() ==
          correctAnswers[currentQuestionIndex].trim().toLowerCase()) {
        userScore++;
      }
      currentQuestionIndex++;
      await _storeQuestionAndOptions(
          currentQuestionIndex); 
      setState(() {
        selectedOption = "";
      });
    } else {
      if (selectedOption.trim().toLowerCase() ==
          correctAnswers[currentQuestionIndex].trim().toLowerCase()) {
        userScore++;
      }
      setState(() {
        selectedOption = ""; 
        _submitAnswer(); 
        double percentage = (userScore / questions.length) * 100;
        print("Final Percentage: $percentage%");
        _resetQuizState(); 
        Navigator.of(context).pushNamedAndRemoveUntil(
        scoreRoute, (route) => false, arguments: percentage);
      });
    }
  }

  void _resetQuizState() {
    setState(() {
      selectedOption = "";
      currentQuestionIndex = 0;
      userScore = 0;
    });
  }

  void _submitAnswer() {
    // Check if the selected option is correct and update the score
    if (selectedOption.trim().toLowerCase() ==
        correctAnswers[currentQuestionIndex].trim().toLowerCase()) {
      userScore++;
    }
    print("Selected Option: $selectedOption");
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
                            child: typoC(
                                user_name, 18, "Open Sans", Colors.white70),
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: typoH("Space"),
                ),
                SizedBox(height: 20),
                FutureBuilder<String>(
                  future: _getQuestion(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: typoC2(snapshot.data!, 22, "Sanchez",
                            Colors.white70, TextAlign.left),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                SizedBox(height: 20),
                FutureBuilder<List<String>>(
                  future: _getOptions(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final options = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final option in options)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, bottom: 12),
                              child: GestureDetector(
                                onTap: () {
                                  _handleRadioValueChange(option);
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 17, 17, 17),
                                    border: Border.all(
                                      color: Colors.white70,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 24.0,
                                          child: Radio(
                                            value: option,
                                            groupValue: selectedOption,
                                            onChanged: _handleRadioValueChange,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 8.0),
                                            child: typoC2(
                                              option,
                                              22,
                                              "Sanchez",
                                              Colors.white70,
                                              TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: 20),
                          Center(
                            child: getSubmitButton(context, () {
                              _loadNextQuestion();
                              _submitAnswer();
                            },
                                currentQuestionIndex < questions.length - 1
                                    ? "Next"
                                    : "Submit"),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}













//movie quiz
class QuizMovie extends StatefulWidget {
  const QuizMovie({super.key});

  @override
  State<QuizMovie> createState() => _QuizMovieState();
}

class _QuizMovieState extends State<QuizMovie> {
  String user_name = "User";
  String selectedOption = "";
  int currentQuestionIndex = 0;
  List<String> questions = [
    "Q. Who won the Academy Award for Best Actor in 2020?",
    "Q. Which film won the Best Picture at the Oscars in 2019?",
    "Q. In the movie 'The Godfather,' what is the name of Vito Corleone's youngest son?",
    "Q. Who directed the 1994 film 'Pulp Fiction'?",
    "Q. What animated film features a character named Simba?"
  ];

  List<List<String>> optionsList = [
    ["Leonardo DiCaprio", "Joaquin Phoenix", "Brad Pitt", "Anthony Hopkins"],
    ["La La Land", "The Shape of Water", "Green Book", "Parasite"],
    ["Michael", "Fredo", "Sonny", "Tom"],
    [
      "Quentin Tarantino",
      "Martin Scorsese",
      "Steven Spielberg",
      "Christopher Nolan"
    ],
    ["The Lion King", "Finding Nemo", "Shrek", "Toy Story"],
  ];

  // Correct answers for each question
  List<String> correctAnswers = [
    "Joaquin Phoenix",
    "Green Book",
    "Fredo",
    "Quentin Tarantino",
    "The Lion King"
  ];

  // User's score
  int userScore = 0;

  @override
  void initState() {
    super.initState();
    _loadUserName().then((_) {
      _resetQuizState();
      _storeQuestionAndOptions(currentQuestionIndex);
    });
  }

  Future<void> _storeQuestionAndOptions(int index) async {
    final box = Hive.box('db');
    final question = questions[index];
    final options = optionsList[index];
    await box.put('question', question);
    await box.put('options', options);
  }

  Future<String> _getQuestion() async {
    final box = Hive.box('db');
    final question = box.get('question');
    return question ?? "No question found";
  }

  Future<List<String>> _getOptions() async {
    final box = Hive.box('db');
    final options = box.get('options');
    return options ?? [];
  }

  Future<void> _loadUserName() async {
    final box = Hive.box('db');
    final savedUserName = box.get('user_name');
    setState(() {
      user_name = savedUserName ?? "User";
    });
  }

  void _handleRadioValueChange(String? value) {
    setState(() {
      selectedOption = value ?? "";
    });
  }

  Future<void> _loadNextQuestion() async {
    if (currentQuestionIndex < questions.length - 1) {

      if (selectedOption.trim().toLowerCase() ==
          correctAnswers[currentQuestionIndex].trim().toLowerCase()) {
        userScore++;
      }
      currentQuestionIndex++;
      await _storeQuestionAndOptions(
          currentQuestionIndex); 
      setState(() {
        selectedOption = "";
      });
    } else {
     
      if (selectedOption.trim().toLowerCase() ==
          correctAnswers[currentQuestionIndex].trim().toLowerCase()) {
        userScore++;
      }
      setState(() {
        selectedOption = ""; 
        _submitAnswer(); 
        double percentage = (userScore / questions.length) * 100;
        print("Final Percentage: $percentage%");
        _resetQuizState(); 
          Navigator.of(context).pushNamedAndRemoveUntil(
        scoreRoute, (route) => false, arguments: percentage);
      });
    }
  }

  void _resetQuizState() {
    setState(() {
      selectedOption = "";
      currentQuestionIndex = 0;
      userScore = 0;
    });
  }

  void _submitAnswer() {
    // Check if the selected option is correct and update the score
    if (selectedOption.trim().toLowerCase() ==
        correctAnswers[currentQuestionIndex].trim().toLowerCase()) {
      userScore++;
    }
    print("Selected Option: $selectedOption");
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
                            child: typoC(
                                user_name, 18, "Open Sans", Colors.white70),
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: typoH("Movies"),
                ),
                SizedBox(height: 20),
                FutureBuilder<String>(
                  future: _getQuestion(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: typoC2(snapshot.data!, 22, "Sanchez",
                            Colors.white70, TextAlign.left),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                SizedBox(height: 20),
                FutureBuilder<List<String>>(
                  future: _getOptions(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final options = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final option in options)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, bottom: 12),
                              child: GestureDetector(
                                onTap: () {
                                  _handleRadioValueChange(option);
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 17, 17, 17),
                                    border: Border.all(
                                      color: Colors.white70,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 24.0,
                                          child: Radio(
                                            value: option,
                                            groupValue: selectedOption,
                                            onChanged: _handleRadioValueChange,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 8.0),
                                            child: typoC2(
                                              option,
                                              22,
                                              "Sanchez",
                                              Colors.white70,
                                              TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: 20),
                          Center(
                            child: getSubmitButton(context, () {
                              _loadNextQuestion();
                              _submitAnswer();
                            },
                                currentQuestionIndex < questions.length - 1
                                    ? "Next"
                                    : "Submit"),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}














//coding quiz


class QuizCoding extends StatefulWidget {
  const QuizCoding({super.key});

  @override
  State<QuizCoding> createState() => _QuizCodingState();
}

class _QuizCodingState extends State<QuizCoding> {
  String user_name = "User";
  String selectedOption = "";
  int currentQuestionIndex = 0;
  List<String> questions = [
    "Q. What does HTML stand for?",
    "Q. In programming, what does the acronym 'API' stand for?",
    "Q. Which programming language is known for its use in machine learning and data science?",
    "Q. What is the purpose of CSS in web development?",
    "Q. In Java, what keyword is used to implement multiple inheritance?"
  ];

  List<List<String>> optionsList = [
    [
      "HyperText Markup Language",
      "HyperText Modeling Language",
      "Highly Typed Machine Learning",
      "Home Tool Markup Language"
    ],
    [
      "Application Programming Interface",
      "Advanced Program Interface",
      "Automated Program Interaction",
      "All Purpose Interface"
    ],
    ["Python", "Java", "C++", "R"],
    [
      "Style the web page",
      "Handle server requests",
      "Create dynamic content",
      "Define the structure of a document"
    ],
    ["extends", "inherits", "implements", "interface"]
  ];


  List<String> correctAnswers = [
    "HyperText Markup Language",
    "Application Programming Interface",
    "Python",
    "Style the web page",
    "implements"
  ];


  int userScore = 0;

  @override
  void initState() {
    super.initState();
    _loadUserName().then((_) {
      _resetQuizState();
      _storeQuestionAndOptions(currentQuestionIndex);
    });
  }

  Future<void> _storeQuestionAndOptions(int index) async {
    final box = Hive.box('db');
    final question = questions[index];
    final options = optionsList[index];
    await box.put('question', question);
    await box.put('options', options);
  }

  Future<String> _getQuestion() async {
    final box = Hive.box('db');
    final question = box.get('question');
    return question ?? "No question found";
  }

  Future<List<String>> _getOptions() async {
    final box = Hive.box('db');
    final options = box.get('options');
    return options ?? [];
  }

  Future<void> _loadUserName() async {
    final box = Hive.box('db');
    final savedUserName = box.get('user_name');
    setState(() {
      user_name = savedUserName ?? "User";
    });
  }

  void _handleRadioValueChange(String? value) {
    setState(() {
      selectedOption = value ?? "";
    });
  }

  Future<void> _loadNextQuestion() async {
  if (currentQuestionIndex < questions.length - 1) {

    if (selectedOption.trim().toLowerCase() ==
        correctAnswers[currentQuestionIndex].trim().toLowerCase()) {
      userScore++;
    }
    currentQuestionIndex++;
    await _storeQuestionAndOptions(
        currentQuestionIndex); 
    setState(() {
      selectedOption = "";
    });
  } else {

    if (selectedOption.trim().toLowerCase() ==
        correctAnswers[currentQuestionIndex].trim().toLowerCase()) {
      userScore++;
    }
    double percentage = (userScore / questions.length) * 100;
    // print("Final Percentage: $percentage%");
    _resetQuizState(); 
    Navigator.of(context).pushNamedAndRemoveUntil(
        scoreRoute, (route) => false, arguments: percentage);
  }
}

  void _resetQuizState() {
    setState(() {
      selectedOption = "";
      currentQuestionIndex = 0;
      userScore = 0;
    });
  }

  void _submitAnswer() {

    if (selectedOption.trim().toLowerCase() ==
        correctAnswers[currentQuestionIndex].trim().toLowerCase()) {
      userScore++;
    }
    print("Selected Option: $selectedOption");
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
                            child: typoC(
                                user_name, 18, "Open Sans", Colors.white70),
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: typoH("Coding"),
                ),
                SizedBox(height: 20),
                FutureBuilder<String>(
                  future: _getQuestion(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: typoC2(snapshot.data!, 22, "Sanchez",
                            Colors.white70, TextAlign.left),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                SizedBox(height: 20),
                FutureBuilder<List<String>>(
                  future: _getOptions(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final options = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final option in options)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, bottom: 12),
                              child: GestureDetector(
                                onTap: () {
                                  _handleRadioValueChange(option);
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 17, 17, 17),
                                    border: Border.all(
                                      color: Colors.white70,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 24.0,
                                          child: Radio(
                                            value: option,
                                            groupValue: selectedOption,
                                            onChanged: _handleRadioValueChange,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 8.0),
                                            child: typoC2(
                                              option,
                                              22,
                                              "Sanchez",
                                              Colors.white70,
                                              TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: 20),
                          Center(
                            child: getSubmitButton(context, () {
                              _loadNextQuestion();
                              _submitAnswer();
                            },
                                currentQuestionIndex < questions.length - 1
                                    ? "Next"
                                    : "Submit"),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
