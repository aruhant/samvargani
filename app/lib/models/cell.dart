import 'package:flutter/material.dart';
import 'package:paheli/utils/string.dart';

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

  String tooltip(String s) {
    switch (this) {
      case CellState.correct:
        return '$s- सही स्थान पर है, सही मात्रा के साथ';
      case CellState.incorrect:
        return '${s.vyanjan} - शब्द में कहीं भी मौजूद नहीं है';
      case CellState.empty:
        return s.trim().isEmpty ? '' : ' ';
      case CellState.misplaced:
        return '$s - शब्द में मौजूद है, लेकिन यह स्थान सही नहीं है';
      case CellState.correctVyanjan:
        return '${s.vyanjan} - सही स्थान पर है, लेकिन यह मात्रा सही नहीं है';
      case CellState.misplacedVyanjan:
        return '${s.vyanjan}  - शब्द में मौजूद है, लेकिन यह स्थान एवं मात्रा सही नहीं है';
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
