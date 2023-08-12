import 'package:flutter/material.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/widgets/daily_game.dart';
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
    game = Game(
        answer: gameAnswers[UserPrefs.instance.practiceGameIndex],
        onSuceess: displayResult);
  }

  displayResult(GameResult result) async {
    bool s = UserPrefs.instance.makeProgress(gameAnswers.length);
    await showDialog(
        context: context,
        builder: (context) => ResultWidget(gameResult: result));
    setState(() {
      if (s) {
        game = Game(
          answer: gameAnswers[UserPrefs.instance.practiceGameIndex],
          onSuceess: displayResult,
        );
      }
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
        footer: (game) =>
            (game.lines.length > 3) || UserPrefs.instance.practiceGameIndex < 5
                ? TextButton(
                    onPressed: () {
                      displayResult(GameResult(
                          win: false, answer: game.answer, lines: game.lines));
                    },
                    child: Text(LocaleKeys.practiceGame_resetButton.tr()),
                  )
                : null,
        header: (game) => ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const DailyGame()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      size: 20,
                    ),
                    // const SizedBox(width: 14),
                    // Text(LocaleKeys.practiceGame_dailyGameButton.tr()),
                  ],
                ),
              ),
            ));
  }
}
