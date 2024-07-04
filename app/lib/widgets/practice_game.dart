import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/widgets/daily_game.dart';
import 'package:paheli/widgets/game_widget.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/widgets/practice_leaderboard.dart';
import 'package:paheli/widgets/result_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/user_properties.dart';

class PracticeGame extends StatefulWidget {
  final int? triesToCompleteDailyGame;
  const PracticeGame({super.key, this.triesToCompleteDailyGame});
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
        answer: practiceWords[UserProperties.instance.practiceGameIndex],
        onSuceess: displayResult,
      );
      completed = game.complete;
      if (completed) {
        UserProperties.instance.makeProgress(practiceWords.length);
      }
    }
  }

  displayResult(GameResult result) async {
    bool s = UserProperties.instance.makeProgress(practiceWords.length);
    // write to leaderboard
    if (UserProperties.instance.name.trim().isNotEmpty &&
        UserProperties.instance.practiceGameIndex > minLevelForLeaderboard) {
      FirebaseDatabase.instance.ref('leaderboard/practice').push().set({
        'name': UserProperties.instance.name,
        'level': UserProperties.instance.practiceGameIndex
      });
    }
    await showDialog(
        context: context,
        builder: (context) => ResultWidget(gameResult: result));
    setState(() {
      if (s) loadGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (practiceWords.length - 1 == UserProperties.instance.practiceGameIndex) {
      return Material(
        color: const Color.fromRGBO(213, 204, 158, 1),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 250.h),
            AutoSizeText(
              LocaleKeys.practiceGame_gameOver.tr(),
              textAlign: TextAlign.center,
              maxFontSize: 40,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.sp,
              ),
              minFontSize: 20,
            ),
          ],
        ),
      );
    }
    return GameWidget(
        game: game,
        footer: (game) => (UserProperties.instance.practiceGameIndex < 4) ||
                (UserProperties.instance.practiceGameIndex < 10 &&
                    game.tries > 3) ||
                (UserProperties.instance.practiceGameIndex < 30 &&
                    game.tries > 5) ||
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
        header: (game) => Padding(
              padding: EdgeInsets.only(top: 10.0.w),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 8.w),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      backgroundColor: Colors.orangeAccent,
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DailyGame()));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(LocaleKeys.practiceGame_dailyGameButton.tr(),
                            style: TextStyle(
                                fontSize: 14.sp, color: Colors.white)),
                      ],
                    ),
                  ),
                  SizedBox(width: 170.w, height: 0),
                  MaterialButton(
                    minWidth: 0,
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return PracticeLeaderboard(
                            triesToCompleteDailyGame:
                                widget.triesToCompleteDailyGame,
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.leaderboard,
                      size: 22.sp,
                    ),
                  ),
                ],
              ),
            ));
  }
}
