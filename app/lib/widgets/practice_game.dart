import 'package:flutter/material.dart';
import 'package:paheli/widgets/game_widget.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/widgets/result_widget.dart';

class PracticeGame extends StatefulWidget {
  const PracticeGame({Key? key}) : super(key: key);

  @override
  PracticeGameState createState() => PracticeGameState();
}

class PracticeGameState extends State<PracticeGame> {
  @override
  void initState() {
    super.initState();
    game = Game(onSuceess: onSuceess);
  }

  late Game game;

  onSuceess(GameResult result) {
    showDialog(
        context: context,
        builder: (context) => ResultWidget(gameResult: result));
    game.reset();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: game);
  }
}
