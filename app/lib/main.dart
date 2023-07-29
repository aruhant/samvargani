import 'package:flutter/material.dart';
import 'package:paheli/models/user_prefs.dart';
import 'package:paheli/widgets/game_help.dart';
import 'package:paheli/widgets/practice_game.dart';

Future<void> main() async {
  await UserPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const PracticeGame(),
      home: (UserPrefs.instance.firstRun)
          ? const GameHelpWidget()
          : const PracticeGame(),
    );
  }
}
