import 'package:flutter/material.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/line.dart';
import 'package:paheli/models/lines.dart';

class Game {
  String word;
  Game(this.word);
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
}
