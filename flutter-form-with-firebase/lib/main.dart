import 'package:flutter/material.dart';
import 'package:flutterform/screens/home_screen.dart';

final kcolorscheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 0, 2, 19));

void main() {
  runApp(MaterialApp(
    theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kcolorscheme,
        scaffoldBackgroundColor: kcolorscheme.background.withOpacity(0.75),
        textTheme: const TextTheme().copyWith(
         titleLarge: TextStyle(
          color: kcolorscheme.onPrimaryContainer
         )
        ),),
    home: const MyApp(),
    themeMode: ThemeMode.dark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
