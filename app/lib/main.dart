import 'package:flutter/material.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/models/line.dart';
import 'package:paheli/models/lines.dart';
import 'package:paheli/widgets/game_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Game game = Game('पहेली');
  MyApp({Key? key}) {
    game.addGuess('हेवेली');
    game.addGuess('अच्छा');
    game.addGuess('बहुत');
    game.addGuess('पहेली');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paheli',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GameWidget(lines: game.lines),
    );
  }
}
