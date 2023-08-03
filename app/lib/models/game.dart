import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/models/user_prefs.dart';
import 'package:paheli/models/wordlist.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/utils/string.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/line.dart';
import 'package:easy_localization/easy_localization.dart';

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
  GameAnswer answer;
  final List<Line> _lines = [];
  final Function(GameResult) onSuceess;
  List<Line> get lines => [
        ..._lines,
        Line(
            cells: List<Cell>.generate(
                answer.answer.allCharacters.length,
                (index) => Cell(
                    answer.answer.allCharacters[index].matra.characters
                        .join(' '),
                    state: CellState.empty)))
      ];
  // Game({required this.onSuceess, required this.answer});
  Game.practice({required this.onSuceess})
      : answer = gameAnswers[UserPrefs.instance.practiceGameIndex];
  int get length => answer.answer.allCharacters.length;
  get answerList => answer.answer.allCharacters;

  String addGuess(String guess) {
    if (guess.toLowerCase() == 'iddqd') return answer.answer;
    List<String> guessList = guess.allCharacters;
    if (length != guessList.length) {
      return LocaleKeys.game_gameMessages_wrongWordLength
          .tr(args: [guessList.length.toString()]);
    }
//  /*    if (guess.contains(RegExp(r'[a-z,A-Z]'))) {
//       // give me a hindi full stop character
//       return 'यह एक हिंदी शब्द है। कोई अंग्रेजी अक्षर मौजूद नहीं हैं।';
//     }
//     // check if guess has any non-hindi character by using not contains
//     if (!guess.contains(RegExp(r'[^ऀ-ॿ]'))) {
//       return 'यह एक हिंदी शब्द है। कोई अंग्रेजी अक्षर मौजूद नहीं हैं।';
//     } */

    if (!kDebugMode && !wordList.contains(guess)) {
      return LocaleKeys.game_gameMessages_notInDictonary.tr(args: [guess]);
    }

    List<Cell> cells = [];
    for (int i = 0; i < guessList.length; i++) {
      cells.add(Cell(guessList[i],
          state: getStateForCell(answer.answer, guessList[i], i)));
    }
    _lines.add(Line(cells: cells));
    if (answer.answer == guess) {
      onSuceess(GameResult(win: true, answer: answer, tries: _lines.length));
      return '';
    }
    return '';
  }

  CellState getStateForCell(String answer, String guessCharacter, int index) {
    if (answer.allCharacters[index] == guessCharacter) {
      return CellState.correct;
    } else if (answer.allCharacters[index].vyanjan == guessCharacter.vyanjan) {
      return CellState.correctVyanjan;
    } else if (answer.allCharacters.contains(guessCharacter)) {
      return CellState.misplaced;
    } else if (answer.allCharacters
        .map((e) => e.vyanjan)
        .contains(guessCharacter.vyanjan)) {
      return CellState.misplacedVyanjan;
    } else {
      return CellState.incorrect;
    }
  }
}

class GameResult {
  final GameAnswer answer;
  int tries;
  bool win;
  GameResult({required this.win, required this.answer, this.tries = 0});
}
