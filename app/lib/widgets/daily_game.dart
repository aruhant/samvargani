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
import 'package:paheli/widgets/practice_game.dart';
import 'package:paheli/widgets/yesterday.dart';
import 'package:paheli/widgets/result_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:screenshot/screenshot.dart';
import '../models/user_prefs.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:in_app_review/in_app_review.dart';

final InAppReview inAppReview = InAppReview.instance;

class DailyGame extends StatefulWidget {
  const DailyGame({Key? key}) : super(key: key);
  @override
  DailyGameState createState() => DailyGameState();
}

class DailyGameState extends State<DailyGame> {
  Game? game;
  bool needPermissions = false;
  @override
  void initState() {
    super.initState();
    print('loading');
    WotD.listen().listen((g) => setState(() {
          print(game?.answer.answer);
          game = Game.load(answer: g.answer, onSuceess: displayResult);
        }));
    hasPermissions().then((value) => setState(() {
          needPermissions = !value;
        }));
  }

  displayResult(GameResult result) async {
    FirebaseAnalytics.instance.logEvent(
        name: 'completed_${DateTime.now().day}_${DateTime.now().month}',
        parameters: {'tries': result.tries});

    await showDialog(
        context: context,
        builder: (context) => ResultWidget(gameResult: result));

    setState(() {});
  }

  final _screenShotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    if (game == null) {
      return makeLoading();
    } else {
      return GameWidget(
          game: game!,
          header: (game) => makeHeader(game, context),
          footer: game!.complete ? (game) => successFooter(context) : null);
    }
  }

  Widget makeHeader(Game game, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                          game.name.allCharacters.map((e) => e.matra).join('_'),
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
                    size: 14.sp,
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
          MaterialButton(
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
                padding: EdgeInsets.all(6.w),
                child: Icon(
                  Icons.calendar_month,
                  size: 18.sp,
                )),
          ),
        ],
      ),
    );
  }

  Material makeLoading() {
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
  }

  successFooter(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime nextMidnight =
        DateTime(now.year, now.month, now.day, WotD.hour, WotD.minute, 1);
    Duration countdown = nextMidnight.difference(now);
    if (countdown.inSeconds < 0) {
      countdown = countdown + const Duration(days: 1);
    }
//    print(countdown);
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
                                answer: g.answer, onSuceess: displayResult);
                          }));
                    },
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    textStyle: TextStyle(
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
          /*  MaterialButton(
            onPressed: () async {
              await requestPermissions();
              testNotification();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: const BorderSide(
                color: Color.fromARGB(255, 43, 81, 100),
                width: 2,
              ),
            ),
            child: Text(LocaleKeys.dailyGame_notification.tr(),
                style: const TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 43, 81, 100))),
          ), */
          /*  MaterialButton(
               onPressed: () async {
           inAppReview.openStoreListing(appStoreId: '6455461367');
               },
               child: const Text('Write a review')), */
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
