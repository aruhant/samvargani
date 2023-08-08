import 'package:flutter/material.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/models/wotd.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/widgets/game_widget.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/widgets/result_widget.dart';
import 'package:easy_localization/easy_localization.dart';

import '../models/user_prefs.dart';

class DailyGame extends StatefulWidget {
  const DailyGame({Key? key}) : super(key: key);
  @override
  DailyGameState createState() => DailyGameState();
}

class DailyGameState extends State<DailyGame> {
  late Game game;
  @override
  void initState() {
    super.initState();
    game = Game(answer: WotD.instance.answer, onSuceess: displayResult);
  }

  displayResult(GameResult result) async {
    await showDialog(
        context: context,
        builder: (context) => ResultWidget(gameResult: result));
    bool s = UserPrefs.instance.makeProgress(gameAnswers.length);
    setState(() {
      if (s) game = Game.practice(onSuceess: displayResult);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (gameAnswers.length - 1 == UserPrefs.instance.practiceGameIndex) {
      return Material(
        child: Center(
          child: Text(
            LocaleKeys.practiceGame_gameOver.tr(),
            style: const TextStyle(fontSize: 30),
          ),
        ),
      );
    }
    return GameWidget(
        game: game,
        footer: TextButton(
          onPressed: () {
            displayResult(
                GameResult(win: false, answer: game.answer, lines: game.lines));
          },
          child: Text(LocaleKeys.practiceGame_resetButton.tr()),
        ));
  }
}
