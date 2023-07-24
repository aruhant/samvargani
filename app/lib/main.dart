import 'package:flutter/material.dart';
import 'package:paheli/widgets/game_help.dart';
import 'package:paheli/widgets/practice_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const PracticeGame(),
      home: GameHelpWidget(),
    );
  }
}
