import 'package:expense_tracker/expence_tracker_app.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

var kcolorscheeme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 39, 2, 103));

var kdarkcolorcheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 84, 5, 219));

void main() {
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//       .then((value) {
//     runApp(MaterialApp(
//       theme: ThemeData(useMaterial3: true),
//       home: const ExpenceTeackerApp(),
//     ));
//   });
  runApp(MaterialApp(
    darkTheme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kdarkcolorcheme,
        scaffoldBackgroundColor: kdarkcolorcheme.secondaryContainer,
        textTheme: const TextTheme().copyWith(
            titleLarge: TextStyle(color: kdarkcolorcheme.onPrimaryContainer)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kdarkcolorcheme.outline,
                foregroundColor: kdarkcolorcheme.onPrimary)
                ),
        iconTheme: const IconThemeData().copyWith(color: kdarkcolorcheme.onPrimaryContainer)
        ),
    theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kcolorscheeme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kcolorscheeme.onPrimaryContainer,
            foregroundColor: kcolorscheeme.primary),
        scaffoldBackgroundColor: kcolorscheeme.primaryContainer),
    home: const ExpenceTeackerApp(),
    themeMode: ThemeMode.system,
  ));
}
