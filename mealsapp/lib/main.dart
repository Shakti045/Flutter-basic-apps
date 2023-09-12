import 'package:flutter/material.dart';
import 'package:mealsapp/navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var kdarkcolorscheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0));
var kcolorscheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 3, 112));
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp( const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData().copyWith(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.black87,
          colorScheme: kdarkcolorscheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: Colors.black12, foregroundColor: Colors.white)),
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kcolorscheme,
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 23, 2, 108),
              foregroundColor: Colors.white),
          scaffoldBackgroundColor: kcolorscheme.secondaryContainer),
      themeMode: ThemeMode.system,
      home: const TabNavigator(),
      // initialRoute: ,
      // routes: {

      // },
    );
  }
}
