import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/widgets/game_widget.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/widgets/result_widget.dart';

class PracticeGame extends StatefulWidget {
  const PracticeGame({Key? key}) : super(key: key);

  @override
  PracticeGameState createState() => PracticeGameState();
}

class PracticeGameState extends State<PracticeGame> {
  late Game game;
  @override
  void initState() {
    super.initState();
    game = Game(
        answer: gameAnswers[Random().nextInt(gameAnswers.length)],
        onSuceess: onSuceess);
  }

  onSuceess(GameResult result) async {
    await showDialog(
        context: context,
        builder: (context) => ResultWidget(gameResult: result));
    game.reset();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: game);
  }
}
