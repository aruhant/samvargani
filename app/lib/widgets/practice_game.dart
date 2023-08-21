import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/widgets/daily_game.dart';
import 'package:paheli/widgets/game_widget.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/widgets/result_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
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
              color: const Color.fromRGBO(213, 204, 158, 1),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.intro_tutorial_mainMessage.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(240, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.orangeAccent,
                      padding: const EdgeInsets.all(15),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(LocaleKeys.intro_tutorial_next.tr(),
                        style: const TextStyle(fontSize: 18)),
                  )
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
        color: const Color.fromRGBO(213, 204, 158, 1),
        child: Center(
          child: Text(
            LocaleKeys.practiceGame_gameOver.tr(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30),
          ),
        ),
      );
    }
    return GameWidget(
        game: game,
        footer: (game) => (UserPrefs.instance.practiceGameIndex == 0)
            ? Container()
            : (UserPrefs.instance.practiceGameIndex < 4 &&
                        game.lines.length > 3) ||
                    (UserPrefs.instance.practiceGameIndex < 30 &&
                        game.lines.length > 8)
                ? TextButton(
                    onPressed: () {
                      displayResult(GameResult(
                          win: false, answer: game.answer, lines: game.lines));
                    },
                    child: Text(LocaleKeys.practiceGame_resetButton.tr()),
                  )
                : null,
        header: (game) => (UserPrefs.instance.practiceGameIndex == 0)
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    backgroundColor: Colors.orangeAccent,
                    padding: const EdgeInsets.all(6),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DailyGame()));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(6.0.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 16.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(LocaleKeys.practiceGame_dailyGameButton.tr(),
                            style: TextStyle(
                                fontSize: 14.sp, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
