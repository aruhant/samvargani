import 'package:flutter/material.dart';
import 'package:paheli/models/wotd.dart';
import 'package:paheli/widgets/game_widget.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/widgets/practice_game.dart';
import 'package:paheli/widgets/result_widget.dart';

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
      setState(
          () => game = Game(answer: value.answer, onSuceess: displayResult));
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
      return const Material(
          color: Color.fromARGB(255, 226, 149, 174),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Loading...'),
              ),
              CircularProgressIndicator(),
            ],
          ));
    } else {
      return GameWidget(
          game: game!,
          footer: game!.complete ? (game) => successFooter(context) : null);
    }
  }

  successFooter(BuildContext context) {
    return Column(
      children: [
        // text - you have completed the daily game with text style
        Text(
          'You have completed the daily game',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        // text come back tmr for more
        Text(
          'Come back tomorrow for more',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        // text -  in the meantime...
        Text(
          'In the meantime...',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
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
            child: Text('Play Practice Game'),
            style: ElevatedButton.styleFrom(
              elevation: 12.0,
              backgroundColor: Colors.deepOrangeAccent,
            ),
          ),
        ),
      ],
    );
  }
}

/*
Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PracticeGame())
                  */
