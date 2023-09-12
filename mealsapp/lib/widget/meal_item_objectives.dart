import 'package:flutter/material.dart';

class MealItemObjectives extends StatelessWidget {
  const MealItemObjectives({super.key, required this.icon, required this.text});
  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 2,),
        Text(text,style: const TextStyle(color:Colors.white),)
      ],
    );
  }
}
