import 'package:flutter/material.dart';

enum CellState {
  correct(),
  incorrect,
  empty,
  misplaced,
  correctVyanjan,
  misplacedVyanjan;

  Color get color {
    switch (this) {
      case CellState.correct:
        return const Color.fromRGBO(129, 178, 154, 1);
      case CellState.incorrect:
        return const Color.fromRGBO(224, 122, 95, 1);
      case CellState.empty:
        return Colors.black12;
      case CellState.misplaced:
        return const Color.fromRGBO(242, 204, 143, 1);
      case CellState.correctVyanjan:
        return const Color.fromRGBO(129, 178, 154, 0.4);
      case CellState.misplacedVyanjan:
        return const Color.fromARGB(255, 242, 183, 143);
    }
  }
}

class HindiCharacter {
  late String matra;
  late String adha;
  String mainLetter = '';
  String value;
  HindiCharacter(this.value) {
    adha = value;
    for (var rune in value.runes) {
      var character = String.fromCharCode(rune);
      if ('ा	िी	ु	ू	ृ	ॄ	ॅ	ॆ	े	ै	ॉ	ॊ	ो	ौ'.contains(character)) {
        matra = character;
      } else if (value.indexOf('्') - value.indexOf(character) == 1) {
        adha = character;
      } else {
        mainLetter = character;
      }
    }
  }
}

class Cell {
  String value;
  Cell(this.value, {this.state = CellState.empty}) {
    myLetter = HindiCharacter(value);
  }
  late HindiCharacter myLetter;
  CellState state = CellState.empty;
}
