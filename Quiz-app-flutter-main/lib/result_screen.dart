import 'package:flutter/material.dart';
import 'package:quizapp/data/questions.dart';
import 'package:quizapp/model/question.dart';
import 'package:quizapp/widgets/result_box.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(this.resetquiz, this.useranswers, {super.key});
  final void Function() resetquiz;
  final List<String> useranswers;
  @override
  Widget build(BuildContext context) {
    const List<Question> allquestions = questions;
    final List<Map<String, Object>> results = [];
    int correctanswers = 0;
    for (int i = 0; i < useranswers.length; i++) {
      var currquestion = allquestions[i];
      if (currquestion.answers[0] == useranswers[i]) {
        correctanswers++;
      }
      results.add({
        'questionnumber': (i + 1).toString(),
        'questiontext': currquestion.questiontext,
        'correctanswer': currquestion.answers[0],
        'useranswer': useranswers[i],
        'isCorrect': currquestion.answers[0] == useranswers[i]
      });
    }
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You scored $correctanswers out of  ${questions.length}',
            style: GoogleFonts.roboto(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...results.map((e) {
                    return Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: ResultBox(
                          questionnumber: e['questionnumber'] as String,
                          questiontext: e['questiontext'] as String,
                          correctanswer: e['correctanswer'] as String,
                          useranswer: e['useranswer'] as String,
                          iscorrect: e['isCorrect'] as bool,
                        ));
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton.icon(
              onPressed: resetquiz,
              icon: const Icon(Icons.refresh),
              label: const Text("Restart quiz"))
        ],
      ),
    );
  }
}
