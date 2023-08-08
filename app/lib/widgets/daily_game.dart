import 'package:flutter/material.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/models/wotd.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/widgets/game_widget.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/widgets/result_widget.dart';
import 'package:easy_localization/easy_localization.dart';

import '../models/user_prefs.dart';

class DailyGame extends StatefulWidget {
  const DailyGame({Key? key}) : super(key: key);
  @override
  DailyGameState createState() => DailyGameState();
}

class DailyGameState extends State<DailyGame> {
  late Game game;
  @override
  void initState() {
    super.initState();
    game = Game(answer: WotD.instance.answer, onSuceess: displayResult);
  }

  displayResult(GameResult result) async {
    await showDialog(
        context: context,
        builder: (context) => ResultWidget(gameResult: result));
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: game);
  }
}
