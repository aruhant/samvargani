import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/utils/string.dart';
import 'package:paheli/widgets/keyboard.dart';
import 'package:paheli/widgets/lines_widget.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({required this.game, super.key});
  final Game game;

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  TextEditingController controller = TextEditingController();
  String message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.game.length} अक्षर का शब्द ढूंढें')),
      backgroundColor: const Color.fromRGBO(244, 241, 222, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('संवर्गनी',
                style: TextStyle(
                    fontSize: 40,
                    color: Color.fromRGBO(61, 64, 91, 1),
                    fontWeight: FontWeight.bold)),
            LinesWidget(
                lines: widget.game.lines, wordLength: widget.game.length),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'उत्तर'),
                onSubmitted: (value) {
                  setState(() {
                    controller.clear();
                    message = widget.game.addGuess(value.trim());
                  });
                },
              ),
            ),
            Text(message),
            HindiKeyboard(
              onTap: (t) => controller.text += t,
              onReturn: () => setState(() {
                message = widget.game.addGuess(controller.text.trim());
                controller.clear();
              }),
              onBackspace: () => setState(() => controller.text = controller
                  .text
                  .substring(0, max(0, controller.text.length - 1))),
              highlights: widget.game.lines
                  .map((line) => line.cells
                      .where((element) => [
                            CellState.correct,
                            CellState.correctVyanjan,
                            CellState.misplaced,
                            CellState.misplacedVyanjan
                          ].contains(element.state))
                      .map((e) => e.value.vyanjan))
                  .expand((element) => element)
                  .toList()
                ..addAll(widget.game.answer.allCharacters.map((e) => e.matra))
                ..add(widget.game.answer.allCharacters
                        .map((e) => e.matra)
                        .join()
                        .contains('्')
                    ? '्'
                    : ''),
              lowlights: widget.game.lines
                  .map((line) => line.cells
                      .where((element) => CellState.incorrect == element.state)
                      .map((e) => e.value.vyanjan))
                  .expand((element) => element)
                  .toList(),
            ),
            TextButton(
              onPressed: () => setState(() => widget.game.reset()),
              child: const Text('रीसेट'),
            ),
          ],
        ),
      ),
    );
  }
}
