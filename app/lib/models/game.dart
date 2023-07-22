import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paheli/models/wordlist.dart';
import 'package:paheli/utils/string.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/line.dart';

const List<String> words = [
  "श्रृंगार",
  "उत्सुकता",
  "आकर्षक",
  "साहसिक",
  "विचित्र",
  "उमंग",
  "ख़ुशबूदार",
  "प्रचंड",
  "मुस्कान",
  "आकर्षित",
  "स्नेह",
  "बेख़बर",
  "प्रेरित",
  "समझौता",
  "धैर्य",
  "उदार",
  "विचारशील",
  "आत्मीयता",
  "विरक्त",
  "संवेदनशील",
  "विश्वास",
  "अभिमान",
  "परिवर्तनशील",
  "स्वतंत्र",
  "उत्साही",
  "संयम",
  "प्रगतिशील",
  "शांत",
  "सहज",
  "आत्मनिर्भर",
  "भव्य",
  "विचारपूर्ण",
  "विकसित",
  "सुखी",
  "प्रसन्न",
  "जिज्ञासु",
  "मित्रभाव",
  "सफल",
  "आक्रोशी",
  "सजग",
  "नम्र",
  "समर्थ",
  "सहानुभूति",
  "प्रशांत",
  "स्थिर",
  "शक्तिशाली",
  "संतुष्ट",
  "अनुशासित",
  "उन्मुक्त",
  "प्रामाणिक",
  "सहायक"
];

class Game {
  late String answer;
  final List<Line> _lines = [];

  List<Line> get lines => [
        ..._lines,
        Line(
            cells: List<Cell>.generate(
                answer.allCharacters.length,
                (index) => Cell(
                    answer.allCharacters[index].matra.characters.join(' '),
                    state: CellState.empty)))
      ];
  Game() {
    answer = words[Random().nextInt(words.length)];
    answer = 'प्रामाणिक';
  }
  int get length => answer.allCharacters.length;
  get answerList => answer.allCharacters;

  String addGuess(String guess) {
    if (guess.toLowerCase() == 'iddqd') return answer;
    List<String> guessList = guess.allCharacters;
    if (length != guessList.length) {
      return 'यह ${guessList.length} अक्षर का शब्द नहीं है!';
    }
    if (!kDebugMode && !wordList.contains(guess)) {
      return 'आपका उत्तर $guess शब्दकोष में नहीं है!';
    }

    List<Cell> cells = [];
    for (int i = 0; i < guessList.length; i++) {
      cells.add(
          Cell(guessList[i], state: getStateForCell(answer, guessList[i], i)));
    }
    _lines.add(Line(cells: cells));
    return '';
  }

  void reset() {
    answer = words[Random().nextInt(words.length)];
    _lines.clear();
  }

  CellState getStateForCell(String answer, String guessCharacter, int index) {
    if (answer.allCharacters[index] == guessCharacter) {
      return CellState.correct;
    } else if (answer.allCharacters[index].vyanjan == guessCharacter.vyanjan) {
      return CellState.correctVyanjan;
    } else if (answer.allCharacters.contains(guessCharacter)) {
      return CellState.misplaced;
    } else if (answer.vyanjan.contains(guessCharacter.vyanjan)) {
      return CellState.misplacedVyanjan;
    } else {
      return CellState.incorrect;
    }
  }
}
