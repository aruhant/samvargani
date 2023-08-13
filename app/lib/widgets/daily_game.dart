import 'package:flutter/material.dart';
import 'package:paheli/models/wotd.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/widgets/game_widget.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/widgets/practice_game.dart';
import 'package:paheli/widgets/result_widget.dart';
import 'package:easy_localization/easy_localization.dart';
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
      print(game!.lines.toList());
    });
  }

  displayResult(GameResult result) async {
    await showDialog(
        context: context,
        builder: (context) => ResultWidget(gameResult: result));
    setState(() {});
  }

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
          footer: game!.complete ? (game) => successFooter(context) : null);
    }
  }

  successFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(12.0),
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
          Text(
            LocaleKeys.dailyGame_line1.tr(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 43, 81, 100),
            ),
          ),
          // text come back tmr for more
          Text(
            LocaleKeys.dailyGame_line2.tr(),
            style: const TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 43, 81, 100),
            ),
          ),
          Text(
            LocaleKeys.dailyGame_line3.tr(),
            style: const TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 43, 81, 100),
            ),
          ),
          // elevated button - play practice game

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PracticeGame()));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.all(12),
              ),
              child: Text(
                LocaleKeys.dailyGame_button.tr(args: [
                  (UserPrefs.instance.practiceGameIndex + 1).toString()
                ]),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                // set style
              ),
            ),
          ),
        ],
      ),
    );
  }
}
