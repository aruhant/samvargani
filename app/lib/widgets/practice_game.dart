import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/widgets/game_widget.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/widgets/result_widget.dart';
import 'package:easy_localization/easy_localization.dart';

import '../models/user_prefs.dart';

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
    game = Game.practice(onSuceess: displayResult);
  }

  displayResult(GameResult result) async {
    await showDialog(
        context: context,
        builder: (context) => ResultWidget(gameResult: result));
    UserPrefs.instance.makeProgress();
    setState(() {
      game = Game.practice(onSuceess: displayResult);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
        game: game,
        footer: TextButton(
          onPressed: () {
            displayResult(GameResult(
                win: false, answer: game.answer, tries: game.lines.length - 1));
          },
          child: Text(LocaleKeys.practiceGame_resetButton.tr()),
        ));
  }
}
