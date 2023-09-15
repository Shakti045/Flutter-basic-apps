import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nativefeaturesofmobile/screens/home_screen.dart';

final kcolorschheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(251, 3, 6, 93)
  );
void main() {
  runApp(const ProviderScope(child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kcolorschheme,
        scaffoldBackgroundColor: Colors.black,
        textTheme:const TextTheme().copyWith(
          titleLarge: TextStyle(color: kcolorschheme.onPrimaryContainer)
        )
        ),
      home:const HomeScreen(),
    );
  }
}
