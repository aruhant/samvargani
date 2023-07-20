import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:paheli/models/wordlist.dart';
import 'package:paheli/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/line.dart';

const List<String> words = [
  "जल",
  "नल",
  "कर",
  "बस",
  "हम",
  "सब",
  "कब",
  "छत",
  "वन",
  "हल",
  "मत",
  "हट",
  "घर",
  "वर",
  "धन",
  "खग",
  "भर",
  "नभ",
  "रस",
  "कमल",
  "खटमल",
  "गज",
  "घर",
  "चख",
  "छत",
  "जल",
  "झपट",
  "ठग",
  "डगर",
  "ढक",
  "रण",
  "तरकश",
  "थरमस",
  "दस",
  "धड़कन",
  "नल",
  "पत्र",
  "फल",
  "बतख",
  "भर",
  "मटर",
  "यज्ञ",
  "रख",
  "लहर",
  "वक",
  "शलगम",
  "सरस",
  "हम"
];

class Game {
  late String answer;
  List<Line> _lines = [];

  List<Line> get lines => [
        ..._lines,
        Line(
            cells: List<Cell>.generate(answer.hindiCharacterList().length,
                (index) => Cell(' ', state: CellState.empty)))
      ];
  Game() {
    answer = words[Random().nextInt(words.length)];
  }
  int get length => answer.hindiCharacterList().length;
  get answerList => answer.hindiCharacterList();

  String addGuess(String guess) {
    if (guess.toLowerCase() == 'iddqd') return answer;
    List<String> guessList = guess.hindiCharacterList();
    if (length != guessList.length) {
      return 'यह ${guessList.length} अक्षर का शब्द नहीं है!';
    }
    if (!kDebugMode && !wordList.contains(guess)) {
      return 'आपका उत्तर $guess शब्दकोष में नहीं है!';
    }

    List<Cell> cells = [];
    for (int i = 0; i < guessList.length; i++) {
      if (answerList[i] == guessList[i]) {
        cells.add(Cell(guessList[i], state: CellState.correct));
      } else if (answer.characters
          .contains(guess.characters.characterAt(i).toString())) {
        cells.add(Cell(guessList[i], state: CellState.misplaced));
      } else {
        cells.add(Cell(guessList[i], state: CellState.incorrect));
      }
    }
    _lines.add(Line(cells: cells));
    return '';
  }

  void reset() {
    answer = words[Random().nextInt(words.length)];
    _lines.clear();
    addGuess(' ' * answer.characters.length);
  }
}
