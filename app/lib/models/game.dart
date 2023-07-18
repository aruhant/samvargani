import 'dart:math';
import 'package:paheli/models/wordlist.dart';

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
  Game() {
    answer = words[Random().nextInt(words.length)];
// add a string filled with spaces, same length as word
    addGuess(' ' * answer.characters.length);
  }
  Lines lines = Lines(lines: []);
  int get length => answer.characters.length;
  String addGuess(String guess) {
    //print(guess + ' ${word.characters.toList()} ' + guess.length.toString());

    if (answer.characters.length != guess.characters.length)
      return 'यह ${guess.characters.length} अक्षर का शब्द नहीं है!';
    if (!wordList.contains(guess))
      return 'आपका उत्तर $guess शब्दकोष में नहीं है!';
    if (guess.trim().isEmpty) {
      lines.addLine(Line(cells: [
        for (int i = 0; i < guess.characters.length; i++)
          Cell('', state: CellState.empty)
      ]));
      return '';
    }
    List<Cell> cells = [];
    for (int i = 0; i < guess.characters.length; i++) {
      if (answer.characters.characterAt(i) == guess.characters.characterAt(i)) {
        cells.add(Cell(guess.characters.characterAt(i).toString(),
            state: CellState.correct));
      } else if (answer.characters
          .contains(guess.characters.characterAt(i).toString())) {
        cells.add(Cell(guess.characters.characterAt(i).toString(),
            state: CellState.misplaced));
      } else {
        cells.add(Cell(guess.characters.characterAt(i).toString(),
            state: CellState.incorrect));
      }
    }
    lines.addLine(Line(cells: cells));
    return '';
  }

  void reset() {
    answer = words[Random().nextInt(words.length)];
    lines = Lines(lines: []);
    addGuess(' ' * answer.characters.length);
  }
}