import 'package:flutter/material.dart';
import 'dart:math';

var randomfromdart = Random();

class RollDice extends StatefulWidget {
  const RollDice({super.key});
  @override
  State<StatefulWidget> createState() {
    return DiceRoll();
  }
}

class DiceRoll extends State<RollDice> {
  int variableindex = 2;
  void handleroll() {
    setState(() {
      variableindex = randomfromdart.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/dice-$variableindex.png',
              width: 200,
            ),
            ElevatedButton(
                onPressed: handleroll, child: const Text("ROLL DICE"))
          ],
        ));
  }
}
