import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paheli/models/wotd.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/utils/share.dart';
import 'package:paheli/utils/string.dart';
import 'package:paheli/widgets/game_widget.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/widgets/help_share.dart';
import 'package:paheli/widgets/practice_game.dart';
import 'package:paheli/widgets/result_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:screenshot/screenshot.dart';
import '../models/user_prefs.dart';

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
    WotD.listen().listen((value) {
      setState(() =>
          game = Game.load(answer: value.answer, onSuceess: displayResult));
    });
  }

  displayResult(GameResult result) async {
    await showDialog(
        context: context,
        builder: (context) => ResultWidget(gameResult: result));
    setState(() {});
  }

  final _screenShotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    if (game == null) {
      return Material(
          color: const Color.fromARGB(255, 226, 149, 174),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(LocaleKeys.dailyGame_loading.tr()),
              ),
              const CircularProgressIndicator(),
            ],
          ));
    } else {
      return GameWidget(
          game: game!,
          header: (game) => Padding(
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
                    if (game.complete) {
                      displayResult(GameResult(
                          win: true, answer: game.answer, lines: game.lines));
                    } else {
                      {
                        _screenShotController
                            .captureFromLongWidget(
                                InheritedTheme.captureAll(
                                  context,
                                  Material(
                                    child: HelpShareWidget(game),
                                  ),
                                ),
                                delay: const Duration(milliseconds: 300),
                                context: context,
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width,
                                ))
                            .then((capturedImage) {
                          shareImage(
                              capturedImage,
                              LocaleKeys.shareHelp_message.tr(args: [
                                game.answer.answer.allCharacters.length
                                    .toString()
                              ]),
                              context);
                        });
                      }
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(6.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.share,
                          size: 14.sp,
                        ),
                        SizedBox(width: 10.w),
                        if (game.complete)
                          Text(LocaleKeys.dailyGame_headerAlt.tr(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.white))
                        else
                          Text(LocaleKeys.dailyGame_header.tr(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
          footer: game!.complete ? (game) => successFooter(context) : null);
    }
  }

  successFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0).w,
      margin: const EdgeInsets.all(12.0).w,
      decoration: const BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // text - you have completed the daily game with text style
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              LocaleKeys.dailyGame_line1.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23.sp,
                color: const Color.fromARGB(255, 43, 81, 100),
              ),
            ),
          ),
          Text(
            LocaleKeys.dailyGame_line2.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp,
              color: const Color.fromARGB(255, 43, 81, 100),
            ),
          ),
          Text(
            LocaleKeys.dailyGame_line3.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp,
              color: const Color.fromARGB(255, 43, 81, 100),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.w),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PracticeGame()));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.all(6),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  LocaleKeys.dailyGame_button.tr(args: [
                    (UserPrefs.instance.practiceGameIndex + 1).toString()
                  ]),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
