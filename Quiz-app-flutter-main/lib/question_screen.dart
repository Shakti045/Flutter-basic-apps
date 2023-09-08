import 'package:flutter/material.dart';
import 'package:quizapp/data/questions.dart';
import 'package:quizapp/widgets/answer_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen(this.setCurrentScreen, this.setUserAnswers, {super.key});
  final void Function(String screen) setCurrentScreen;
  final void Function({String answer}) setUserAnswers;
  @override
  State<StatefulWidget> createState() {
    return _QuestionWithOption();
  }
}

class _QuestionWithOption extends State<QuestionScreen> {
  int index = 0;
  void gotnextquestion(String answer) {
    widget.setUserAnswers(answer: answer);
    if (index + 1 == questions.length) {
      return widget.setCurrentScreen('result-screen');
    }
    setState(() {
      index = index + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentquestion = questions[index];
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              currentquestion.questiontext,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            ...currentquestion.shuffledanswers.map((answer) {
              return AnswerButton(
                  answer: answer,
                  onTap: () {
                    gotnextquestion(answer);
                  });
            })
          ],
        ),
      ),
    );
  }
}
