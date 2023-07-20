enum CellState {
  correct,
  incorrect,
  empty,
  misplaced,
  partiallyCorrect,
  partiallMisplaced,
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
