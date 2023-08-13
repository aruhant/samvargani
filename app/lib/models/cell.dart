import 'package:flutter/material.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/utils/string.dart';
import 'package:easy_localization/easy_localization.dart';

enum CellState {
  correct,
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
    bool containsMatra = s.matraOnly.isNotEmpty;
    bool containsAdha = s.halfOnly.isNotEmpty;

    switch (this) {
      case CellState.correct:
        if (containsMatra) {
          if (containsAdha) {
            return LocaleKeys.cellTooltip_correctWithMatraAndAdha.tr(args: [s]);
          } else {
            return LocaleKeys.cellTooltip_correctWithMatra.tr(args: [s]);
          }
        } else {
          if (containsAdha) {
            return LocaleKeys.cellTooltip_correctWithAdha.tr(args: [s]);
          } else {
            return LocaleKeys.cellTooltip_correctWithoutMatraAndAdha
                .tr(args: [s]);
          }
        }
      case CellState.correctVyanjan:
        if (containsMatra) {
          if (containsAdha) {
            return LocaleKeys.cellTooltip_correctVyanjanWithMatraAndAdha
                .tr(args: [s.vyanjan, s.halfOnly, s.matraOnly]);
          } else {
            return LocaleKeys.cellTooltip_correctVyanjanWithMatra
                .tr(args: [s.vyanjan, s.matraOnly]);
          }
        } else {
          if (containsAdha) {
            return LocaleKeys.cellTooltip_correctVyanjanWithAdha
                .tr(args: [s.vyanjan, s.halfOnly]);
          } else {
            return LocaleKeys.cellTooltip_correctVyanjanWithoutMatraAndAdha
                .tr(args: [s.vyanjan]);
          }
        }
      case CellState.misplaced:
        if (containsMatra) {
          if (containsAdha) {
            return LocaleKeys.cellTooltip_misplacedWithMatraAndAdha
                .tr(args: [s]);
          } else {
            return LocaleKeys.cellTooltip_misplacedWithMatra.tr(args: [s]);
          }
        } else {
          if (containsAdha) {
            return LocaleKeys.cellTooltip_misplacedWithAdha.tr(args: [s]);
          } else {
            return LocaleKeys.cellTooltip_misplacedWithoutMatraAndAdha
                .tr(args: [s]);
          }
        }

      case CellState.misplacedVyanjan:
        if (containsMatra) {
          if (containsAdha) {
            return LocaleKeys.cellTooltip_misplacedVyanjanWithMatraAndAdha
                .tr(args: [s.vyanjan, s.halfOnly, s.matraOnly]);
          } else {
            return LocaleKeys.cellTooltip_misplacedVyanjanWithMatra
                .tr(args: [s.vyanjan, s.matraOnly]);
          }
        } else {
          if (containsAdha) {
            return LocaleKeys.cellTooltip_misplacedVyanjanWithAdha
                .tr(args: [s.vyanjan, s.halfOnly]);
          } else {
            return LocaleKeys.cellTooltip_misplacedVyanjanWithoutMatraAndAdha
                .tr(args: [s.vyanjan]);
          }
        }
      case CellState.incorrect:
        return LocaleKeys.cellTooltip_incorrect.tr(args: [s.vyanjan]);
      case CellState.empty:
        if (containsMatra) {
          if (containsAdha) {
            s += 'A';
            return LocaleKeys.cellTooltip_emptyWithMatraAndAdha
                .tr(args: [s.halfOnly, s.matraOnly]);
          } else {
            return LocaleKeys.cellTooltip_emptyWithMatra.tr(args: [s]);
          }
        } else {
          if (containsAdha) {
            return LocaleKeys.cellTooltip_emptyWithAdha.tr(args: [s]);
          } else {
            return LocaleKeys.cellTooltip_emptyWithoutMatraAndAdha.tr();
          }
        }
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
  late HindiCharacter myLetter;
  CellState state;
  Cell(this.value, {this.state = CellState.empty}) {
    myLetter = HindiCharacter(value);
  }

  static Cell fromJson(Map<String, dynamic> json) {
    return Cell(
      json['value'] as String,
      state: CellState.values[json['state'] as int],
    );
  }

  Map<String, dynamic> toJson() => {
        'value': value,
        'state': state.index,
      };
}
