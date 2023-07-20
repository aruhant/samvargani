import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:paheli/models/wordlist.dart';
import 'package:paheli/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/line.dart';
import 'package:paheli/models/lines.dart';

const List<String> words = [
  'नमस्ते',
  'शुक्रिया',
  'खुशी',
  'प्यार',
  'दोस्त',
  'किताब',
  'खाना',
  'पानी',
  'सुंदर',
  'अच्छा',
  'माँ',
  'बाप',
  'भाई',
  'बहन',
  'समय',
  'खेल',
  'गाना',
  'सफेद',
  'काला',
  'सूरज',
  'चांद',
  'तारा',
  'फूल',
  'वृक्ष',
  'पक्षी',
  'बारिश',
  'हवा',
  'मिट्टी',
  'समुद्र',
  'गगन',
  'आग',
  'धूप',
  'छाता',
  'चिड़िया',
  'बंदर',
  'बच्चा',
  'मिठाई',
  'पूजा',
  'धन',
  'विद्या',
  'ग्रंथ',
  'ज्ञान',
  'स्वास्थ्य',
  'सौंदर्य',
  'समृद्धि',
  'यात्रा',
  'संगीत',
  'नृत्य',
  'कला',
  'महान'
];

class Game {
  late String answer;
  Lines _lines = Lines(lines: []);
  Lines get lines => (_lines.lines.length == 0)
      ? Lines(
          lines: [
            Line(
                cells: List<Cell>.generate(answer.characters.length,
                    (index) => Cell(' ', state: CellState.empty)))
          ],
        )
      : _lines;
  Game() {
    answer = words[Random().nextInt(words.length)];
  }
  int get length => answer.hindiCharacterList().length;
  get answerList => answer.hindiCharacterList();

  String addGuess(String guess) {
    List<String> guessList = guess.hindiCharacterList();
    if (length != guessList.length)
      return 'यह ${guessList.length} अक्षर का शब्द नहीं है!';
    if (!kDebugMode && !wordList.contains(guess))
      return 'आपका उत्तर $guess शब्दकोष में नहीं है!';

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
    _lines.addLine(Line(cells: cells));
    return '';
  }

  void reset() {
    answer = words[Random().nextInt(words.length)];
    _lines = Lines(lines: []);
    addGuess(' ' * answer.characters.length);
  }
}
