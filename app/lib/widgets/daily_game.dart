import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paheli/models/wotd.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/utils/notifications.dart';
import 'package:paheli/utils/share.dart';
import 'package:paheli/utils/string.dart';
import 'package:paheli/widgets/game_widget.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/widgets/help_share.dart';
import 'package:paheli/widgets/daily_leaderboard.dart';
import 'package:paheli/widgets/practice_game.dart';
import 'package:paheli/widgets/yesterday.dart';
import 'package:paheli/widgets/result_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:screenshot/screenshot.dart';
import '../models/user_properties.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:in_app_review/in_app_review.dart';

final InAppReview inAppReview = InAppReview.instance;

class DailyGame extends StatefulWidget {
  const DailyGame({super.key});
  @override
  DailyGameState createState() => DailyGameState();
}

class DailyGameState extends State<DailyGame> {
  Game? game;
  bool needPermissions = false;
  @override
  void initState() {
    super.initState();
    //print('loading');

    // Listen for changes in the Word of the Day (WotD) and update the game accordingly
    WotD.listen().listen((g) => mounted
        ? setState(() {
            game = Game.load(
                answer: g.answer,
                onSuceess: dailyGameOnSuccess,
                onGuess: onGuess,
                gameType: GameType.daily);
          })
        : null);

    // Check if the app has necessary permissions and update the state accordingly
    hasPermissions().then((value) => setState(() {
          needPermissions = !value;
        }));

    // Load the Word of the Day and update the game after a certain delay
    Duration nextUpdateIn = getCountdownDuration(1);
    Future.delayed(nextUpdateIn).then((value) => setState(() {
          WotD.load().then((g) => setState(() {
                game = Game.load(
                    answer: g.answer,
                    onSuceess: dailyGameOnSuccess,
                    onGuess: onGuess,
                    gameType: GameType.daily);
              }));
        }));
  }

  // Calculate the countdown duration until the next midnight
  Duration getCountdownDuration([int seconds = 0]) {
    DateTime now = DateTime.now();
    DateTime nextMidnight =
        DateTime(now.year, now.month, now.day, WotD.hour, WotD.minute, 1);
    Duration countdown = nextMidnight.difference(now);
    if (countdown.inSeconds < 0) {
      countdown = countdown + Duration(days: 1, seconds: seconds);
    }
    return countdown;
  }

  // Handle the user's guess in the game
  void onGuess(String guess) {
    if (UserProperties.instance.runCount < 5) {
      FirebaseAnalytics.instance.logEvent(
          name: 'dg${game!.tries + 1}',
          parameters: {'answer': game!.name, 'guess': guess});
      if (game?.tries == 0) {
        FirebaseAnalytics.instance.logEvent(
            name: 'started_${DateTime.now().day}_${DateTime.now().month}',
            parameters: {'ttp': UserProperties.instance.tooltipsPressed});
      }
    }
  }

  dailyGameOnSuccess(GameResult result) async {
    if (UserProperties.instance.name != '') {
      // write to leaderboard
      FirebaseDatabase.instance
          .ref('leaderboard/${WotD.day}/${UserProperties.instance.uid}')
          .set({
        'name': UserProperties.instance.name,
        'score': result.tries,
        'UTC': ServerValue.timestamp,
        'local': DateTime.now().toString(),
      });
    }
    FirebaseAnalytics.instance.logEvent(
        name: 'completed_${DateTime.now().day}_${DateTime.now().month}',
        parameters: {'tries': result.tries});
    await displayResult(result);
  }

  // Display the result of the game and log analytics events
  displayResult(GameResult result) async {
    await showDialog(
        context: context,
        builder: (context) => ResultWidget(gameResult: result));

    setState(() {});
  }

  // sets screenshot controller for sharing
  final _screenShotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    if (game == null) {
      return DailyGameLoading();
    } else {
      return GameWidget(
          key: ObjectKey(game),
          game: game!,
          header: (game) => makeHeader(game, context),
          footer: game!.complete ? (game) => successFooter(context) : null);
    }
  }

  // contains share button, leaderboard button and yesterday's word button
  Widget makeHeader(Game game, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 10.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          ElevatedButton(
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
                    win: true,
                    answer: game.answer,
                    lines: game.lines,
                    gameType: GameType.daily));
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
                          game.name.characters.toList().map((e) => e.allModifiers).join('_'),
                          game.length.toString()
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
                    size: 18.sp,
                  ),
                  SizedBox(width: 10.w),
                  if (game.complete)
                    Text(LocaleKeys.dailyGame_headerAlt.tr(),
                        style: TextStyle(fontSize: 14.sp, color: Colors.white))
                  else
                    Text(LocaleKeys.dailyGame_header.tr(),
                        style: TextStyle(fontSize: 14.sp, color: Colors.white)),
                ],
              ),
            ),
          ),
          Row(
            children: [
              // Button to show leaderboard
              MaterialButton(
                minWidth: 0,
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return DailyLeaderboard(
                            tries: game.tries,
                            hasCompletedDailyGame: game.complete);
                      });
                },
                child: Padding(
                    padding: EdgeInsets.only(left: 6.w, top: 6.w, bottom: 6.w),
                    child: Icon(
                      Icons.leaderboard,
                      size: 22.sp,
                    )),
              ),
              // Button to show yesterday's word
              MaterialButton(
                minWidth: 0,
                onPressed: () async {
                  WotD w = (await WotD.load());
                  // ignore: use_build_context_synchronously
                  await showDialog(
                      context: context,
                      builder: (context) => Container(
                          padding: EdgeInsets.all(8.w),
                          margin: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: w.yesterdayAnswer.backgroundColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: YesterdayWord(answer: w.yesterdayAnswer)));
                },
                child: Padding(
                    padding: EdgeInsets.only(left: 6.w, top: 6.w, bottom: 6.w),
                    child: Icon(
                      Icons.calendar_month,
                      size: 22.sp,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Create the success footer widget
  successFooter(BuildContext context) {
    Duration countdown = getCountdownDuration();
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
          MaterialButton(
              minWidth: 0,
              onPressed: () async {
                bool result = await requestPermissions();
                setState(() {
                  needPermissions = !result;
                });
                if (result) setupNotification();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SlideCountdown(
                    duration: countdown,
                    shouldShowHours: (_) => true,
                    shouldShowMinutes: (_) => true,
                    separatorStyle: TextStyle(
                      fontSize: 20.sp,
                      color: const Color.fromARGB(255, 43, 81, 100),
                    ),
                    onDone: () {
                      WotD.load().then((g) => setState(() {
                            game = Game.load(
                                answer: g.answer,
                                onSuceess: dailyGameOnSuccess,
                                onGuess: onGuess,
                                gameType: GameType.daily);
                          }));
                    },
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color.fromARGB(255, 43, 81, 100)),
                  ),
                  if (needPermissions)
                    Icon(
                      Icons.notifications,
                      size: 22.sp,
                      color: const Color.fromARGB(255, 43, 81, 100),
                    ),
                ],
              )),
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
                    builder: (context) =>
                        PracticeGame(triesToCompleteDailyGame: game!.tries)));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.all(6),
              ),
              child: Padding(
                padding: EdgeInsets.all(6.w),
                child: Text(
                  LocaleKeys.dailyGame_button.tr(args: [
                    (UserProperties.instance.practiceGameIndex + 1).toString()
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

class DailyGameLoading extends StatefulWidget {
  @override
  State<DailyGameLoading> createState() => _DailyGameLoadingState();
}

class _DailyGameLoadingState extends State<DailyGameLoading> {
  bool showAdditionalMessage = false;

  @override
  void initState() {
    super.initState();
    // Start a timer after 10 seconds to show the additional message
    Timer(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          showAdditionalMessage = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 226, 149, 174),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (!showAdditionalMessage)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(LocaleKeys.dailyGame_loading.tr()),
            ),
          if (showAdditionalMessage)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(LocaleKeys.dailyGame_noInternet.tr()),
            ),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
