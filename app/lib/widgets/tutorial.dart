import 'package:flutter/material.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/models/user_prefs.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:paheli/widgets/daily_game.dart';
import 'package:paheli/widgets/game_widget.dart';

class TransitionPage extends StatelessWidget {
  TransitionPage({super.key});

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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mainMessages[UserPrefs.instance.tutorialIndex - 1],
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
              child: Text(nextMessages[UserPrefs.instance.tutorialIndex - 1],
                  style: const TextStyle(fontSize: 18)),
            )
          ],
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
      answer: tutorialWords[UserPrefs.instance.tutorialIndex],
      onSuceess: generateNextTutorial,
      onGuess: onGuess,
    );
  }

  generateNextTutorial(GameResult uselessResult) async {
    bool s = UserPrefs.instance.makeTutorialProgress(tutorialWords.length);

    await showDialog(
        context: context,
        builder: (context) => TransitionPage(),
        barrierDismissible: false);

    if (s) {
      game = Game.load(
        answer: tutorialWords[UserPrefs.instance.tutorialIndex],
        onSuceess: generateNextTutorial,
        onGuess: onGuess,
      );
      setState(() {});
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const DailyGame()));
    }

    FirebaseAnalytics.instance
        .logEvent(name: 't${UserPrefs.instance.tutorialIndex}complete');
    return;
  }

  void onGuess(String guess) {
    if (UserPrefs.instance.tutorialIndex == 0 &&
        guess != 'नकद' &&
        guess != 'बालक') {
      FirebaseAnalytics.instance
          .logEvent(name: 'tg${game.tries - 1}', parameters: {'guess': guess});
    }
  }

  @override
  Widget build(BuildContext context) => GameWidget(
        game: game,
      );
}
