import 'package:flutter/material.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/models/user_properties.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:paheli/widgets/daily_game.dart';
import 'package:paheli/widgets/game_widget.dart';

class TransitionPage extends StatelessWidget {
  const TransitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mainMessages = [
      LocaleKeys.intro_tutorial_tutorial1_mainMessage.tr(),
      LocaleKeys.intro_tutorial_tutorial2_mainMessage.tr(),
      LocaleKeys.intro_tutorial_tutorial3_mainMessage.tr(),
    ];
    final nextMessages = [
      LocaleKeys.intro_tutorial_tutorial1_next.tr(),
      LocaleKeys.intro_tutorial_tutorial2_next.tr(),
      LocaleKeys.intro_tutorial_tutorial3_next.tr(),
    ];
    return Material(
        color: const Color.fromRGBO(213, 204, 158, 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                mainMessages[UserProperties.instance.tutorialIndex - 1],
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
                child: Text(
                    nextMessages[UserProperties.instance.tutorialIndex - 1],
                    style: const TextStyle(fontSize: 18)),
              )
            ],
          ),
        ));
  }
}

class Tutorial extends StatefulWidget {
  const Tutorial({super.key});
  @override
  State<Tutorial> createState() => TutorialState();
}

class TutorialState extends State<Tutorial> {
  late Game game;
  @override
  void initState() {
    super.initState();
    game = Game.load(
      answer: tutorialWords[UserProperties.instance.tutorialIndex],
      id: UserProperties.instance.tutorialIndex,
      title: tutorialWords[UserProperties.instance.tutorialIndex].title ?? switch (UserProperties.instance.tutorialIndex + 1) {
        1 => LocaleKeys.intro_tutorial_tutorial1_title.tr(),
        2 => LocaleKeys.intro_tutorial_tutorial2_title.tr(),
        3 => LocaleKeys.intro_tutorial_tutorial3_title.tr(),
        _ => '',
      },
      onSuccess: generateNextTutorial,
      onGuess: onGuess,
      gameType: GameType.tutorial,
    );
  }

  generateNextTutorial(GameResult uselessResult) async {
    if (UserProperties.instance.tutorialIndex == 0) {
      FirebaseAnalytics.instance.logEvent(
          name: 't${UserProperties.instance.tutorialIndex + 1}complete',
          parameters: {'tries': game.tries - 2});
    } else {
      FirebaseAnalytics.instance.logEvent(
          name: 't${UserProperties.instance.tutorialIndex + 1}complete',
          parameters: {'tries': game.tries});
    }

    bool s = UserProperties.instance.makeTutorialProgress(tutorialWords.length);

    await showDialog(
        context: context,
        builder: (context) => const TransitionPage(),
        barrierDismissible: false);

    if (s) {
      game = Game.load(
        answer: tutorialWords[UserProperties.instance.tutorialIndex],
        id: UserProperties.instance.tutorialIndex,
        title: practiceWords[UserProperties.instance.practiceGameIndex].title ?? switch (UserProperties.instance.tutorialIndex + 1) {
          1 => LocaleKeys.intro_tutorial_tutorial1_title.tr(),
          2 => LocaleKeys.intro_tutorial_tutorial2_title.tr(),
          3 => LocaleKeys.intro_tutorial_tutorial3_title.tr(),
          _ => '',
        },
        onSuccess: generateNextTutorial,
        onGuess: onGuess,
        gameType: GameType.tutorial,
      );
      if (UserProperties.instance.tutorialIndex == 1) {
        game.addGuess('शायद');
        game.addGuess('बालक');
      }
      setState(() {});
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const DailyGame()));
    }

    return;
  }

  void onGuess(String guess) {
    if (UserProperties.instance.tutorialIndex == 0) {
      if (guess != 'शायद' && guess != 'बालक') {
        FirebaseAnalytics.instance.logEvent(
            name: 't1g${game.tries - 1}', parameters: {'guess': guess});
        if (game.tries == 2) {
          FirebaseAnalytics.instance.logEvent(
              name: 't1begin',
              parameters: {'ttp': UserProperties.instance.tooltipsPressed});
        }
      }
    } else {
      FirebaseAnalytics.instance.logEvent(
          name:
              't${UserProperties.instance.tutorialIndex + 1}g${game.tries + 1}',
          parameters: {'guess': guess});
      if (game.tries == 0) {
        FirebaseAnalytics.instance.logEvent(
            name: 't${UserProperties.instance.tutorialIndex + 1}begin',
            parameters: {'ttp': UserProperties.instance.tooltipsPressed});
      }
    }
  }

  @override
  Widget build(BuildContext context) => GameWidget(
        key: ObjectKey(game),
        game: game,
      );
}
