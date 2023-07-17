import 'dart:math';

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
  late String word;
  Game() {
    word = words[Random().nextInt(words.length)];
// add a string filled with spaces, same length as word
    addGuess(' ' * word.characters.length);
  }
  Lines lines = Lines(lines: []);
  int get length => word.characters.length;
  bool addGuess(String guess) {
    print(guess + ' ${word.characters.toList()} ' + guess.length.toString());
    if (word.characters.length != guess.characters.length) return false;
    List<Cell> cells = [];
    for (int i = 0; i < guess.characters.length; i++) {
      if (word.characters.characterAt(i) == guess.characters.characterAt(i)) {
        cells.add(Cell(guess.characters.characterAt(i).toString(),
            state: CellState.correct));
      } else if (word.characters
          .contains(guess.characters.characterAt(i).toString())) {
        cells.add(Cell(guess.characters.characterAt(i).toString(),
            state: CellState.misplaced));
      } else {
        cells.add(Cell(guess.characters.characterAt(i).toString(),
            state: CellState.incorrect));
      }
    }
    lines.addLine(Line(cells: cells));
    return true;
  }

  void reset() {
    word = words[Random().nextInt(words.length)];
  }
}
