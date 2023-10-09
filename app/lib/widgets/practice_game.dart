import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    loadGame();
  }

  void loadGame() {
    bool completed = true;
    while (completed) {
      game = Game.load(
        answer: practiceWords[UserPrefs.instance.practiceGameIndex],
        onSuceess: displayResult,
      );
      completed = game.complete;
    }
  }

  displayResult(GameResult result) async {
    bool s = UserPrefs.instance.makeProgress(practiceWords.length);
    await showDialog(
        context: context,
        builder: (context) => ResultWidget(gameResult: result));
    setState(() {
      if (s) loadGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (practiceWords.length - 1 == UserPrefs.instance.practiceGameIndex) {
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
        footer: (game) => (UserPrefs.instance.practiceGameIndex < 4) ||
                (UserPrefs.instance.practiceGameIndex < 10 && game.tries > 3) ||
                (UserPrefs.instance.practiceGameIndex < 30 && game.tries > 5) ||
                game.tries > 10 ||
                kDebugMode
            ? TextButton(
                onPressed: () {
                  displayResult(GameResult(
                      win: false, answer: game.answer, lines: game.lines));
                },
                child: Text(LocaleKeys.practiceGame_resetButton.tr()),
              )
            : null,
        header: (game) => Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0.w, top: 10.h),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
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
                ),
              ],
            ));
  }
}
