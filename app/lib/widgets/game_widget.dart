import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/models/lines.dart';
import 'package:paheli/widgets/lines_widget.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({required this.game, super.key});
  final Game game;

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  String guess = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          LinesWidget(lines: widget.game.lines, wordLength: widget.game.length),
          TextField(
            controller: TextEditingController(text: guess),
            onChanged: (value) => setState(() => guess = value),
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'उत्तर'),
            onSubmitted: (value) {
              setState(() {
                guess = '';
                widget.game.addGuess(value);
              });
            },
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.game.reset();
              });
            },
            child: Text('रीसेट'),
          ),
        ],
      ),
    );
  }
}
