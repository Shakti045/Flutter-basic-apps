import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultBox extends StatelessWidget {
  const ResultBox(
      {super.key,
      required this.questionnumber,
      required this.questiontext,
      required this.correctanswer,
      required this.useranswer,
      required this.iscorrect});
  final String questionnumber;
  final String questiontext;
  final String useranswer;
  final String correctanswer;
  final bool iscorrect;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          width: 50,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iscorrect ? Colors.green : Colors.red),
          child: Center(
              child: Text(
            questionnumber,
            style: const TextStyle(color: Colors.white),
          )),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                questiontext,
                style: GoogleFonts.lato(
                    color: Colors.indigo,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Your answer is $useranswer',
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                'Correctanswer is $correctanswer',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
