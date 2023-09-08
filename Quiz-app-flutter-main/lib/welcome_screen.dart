import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen(this.setCurrentScreen, {super.key});
  final void Function(String screen) setCurrentScreen;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 150,
            color: const Color.fromARGB(119, 254, 254, 255),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Welcome to flutter quiz app',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          OutlinedButton.icon(
              onPressed: () {
                setCurrentScreen('question-screen');
              },
              icon: const Icon(Icons.arrow_right_alt),
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                foregroundColor: Colors.white,
                backgroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              label: const Text('Start quiz'))
        ],
      ),
    );
  }
}
