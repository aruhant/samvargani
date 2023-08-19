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
    game = Game.load(
        answer: gameAnswers[UserPrefs.instance.practiceGameIndex],
        onSuceess: displayResult);
  }

  displayResult(GameResult result) async {
    bool s = UserPrefs.instance.makeProgress(gameAnswers.length);
    if (UserPrefs.instance.practiceGameIndex == 1) {
      await showDialog(
          context: context,
          builder: (context) => Material(
                  child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " LocaleKeys.practiceGame_tutorialOver.tr()",
                    style: const TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.orangeAccent,
                        padding: const EdgeInsets.all(6),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Next"))
                ],
              )),
          barrierDismissible: false);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const DailyGame()));
      return;
    }
    await showDialog(
        context: context,
        builder: (context) => ResultWidget(gameResult: result));
    setState(() {
      if (s) {
        game = Game.load(
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
        header: (game) => Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.all(6),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PracticeGame()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_back,
                        size: 14,
                      ),
                      const SizedBox(width: 14),
                      Text(LocaleKeys.practiceGame_dailyGameButton.tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ));
  }
}
