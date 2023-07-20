import 'package:flutter/material.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/utils/string.dart';
import 'package:paheli/widgets/game_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Game game = Game();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("अँग्रेजों".hindiCharacterList());
    return MaterialApp(
      title: '${game.length} अक्षर का शब्द ढूंढें',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GameWidget(game: game),
    );
  }
}
