import 'package:expense_tracker/expence_tracker_app.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
     MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home:const ExpenceTeackerApp(),
    )
  );
}
