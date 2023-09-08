import 'package:flutter/material.dart';
import 'package:quizapp/welcome_screen.dart';
import 'package:quizapp/question_screen.dart';
import 'package:quizapp/result_screen.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<QuizApp> {
  var currentScreen = 'welcome-screen';
  List<String> useranswers = [];

  void setCurrentScreen(String screen) {
    setState(() {
      currentScreen = screen;
    });
  }

  void setUserAnswers({answer}) {
    if (answer != null) {
      useranswers.add(answer);
    }
  }

  void resetquiz() {
    setState(() {
      useranswers = [];
      currentScreen = 'question-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screen = WelcomeScreen(setCurrentScreen);
    if (currentScreen == 'question-screen') {
      screen = QuestionScreen(setCurrentScreen, setUserAnswers);
    }
    if (currentScreen == 'result-screen') {
      screen = ResultScreen(resetquiz,useranswers);
    }
    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 102, 1, 120),
                Color.fromARGB(255, 10, 4, 103),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: screen),
      ),
    );
  }
}
