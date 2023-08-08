import 'package:flutter/material.dart';
import 'package:paheli/models/wotd.dart';
import 'package:paheli/widgets/game_widget.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/widgets/result_widget.dart';

class DailyGame extends StatefulWidget {
  const DailyGame({Key? key}) : super(key: key);
  @override
  DailyGameState createState() => DailyGameState();
}

class DailyGameState extends State<DailyGame> {
  Game? game;
  @override
  void initState() {
    super.initState();
    WotD.load().then((value) => setState(
        () => game = Game(answer: value.answer, onSuceess: displayResult)));
  }

  displayResult(GameResult result) async {
    await showDialog(
        context: context,
        builder: (context) => ResultWidget(gameResult: result));
  }

  @override
  Widget build(BuildContext context) {
    if (game == null) {
      return const Material(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else
      return GameWidget(game: game!);
  }
}
