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

class Game {
  GameAnswer answer;
  final List<Line> _loadLines;
  final Function(GameResult) onSuceess;
  List<Line> get lines => [
        ..._loadLines,
        Line(
            cells: List<Cell>.generate(
                answer.answer.allCharacters.length,
                (index) => Cell(
                    answer.answer.allCharacters[index].matra.characters
                        .join(' '),
                    state: CellState.empty)))
      ];
  Game(
      {required this.onSuceess,
      required this.answer,
      List<Line> loadLines = const []})
      : _loadLines = loadLines;
  Game.load({required this.onSuceess, required this.answer})
      : _loadLines =
            UserPrefs.instance.loadGame(answer.answer)?._loadLines ?? [];
  int get length => answer.answer.allCharacters.length;
  List<String> get answerList => answer.answer.allCharacters;
  bool get complete =>
      _loadLines.isNotEmpty &&
      answer.answer == _loadLines.last.cells.map((e) => e.value).join();

  String get name => answer.answer;

  Future<String> addGuess(String guess) async {
    if (guess.toLowerCase() == 'iddqd') return answer.answer;
    if (guess.toLowerCase() == 'clear') {
      await UserPrefs.instance.clear();
      return 'Cleared';
    }
    if (guess.replaceAll(' ', '').toLowerCase() == 'warpten') {
      onSuceess(GameResult(win: true, answer: answer, lines: lines));
      return answer.answer;
    }
    List<String> guessList = guess.allCharacters;
    if (length != guessList.length) {
      return LocaleKeys.game_gameMessages_wrongWordLength
          .tr(args: [guessList.length.toString()]);
    }

    if (!kDebugMode && !wordList.contains(guess)) {
      return LocaleKeys.game_gameMessages_notInDictonary.tr(args: [guess]);
    }

    List<Cell> cells = [];
    for (int i = 0; i < guessList.length; i++) {
      cells.add(Cell(guessList[i],
          state: getStateForCell(answer.answer, guessList[i], i)));
    }
    _loadLines.add(Line(cells: cells));
    UserPrefs.instance.saveGame(this);
    if (answer.answer == guess) {
      onSuceess(GameResult(win: true, answer: answer, lines: lines));
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

  static Game fromJson(Map json) {
    print('Loading liunes${json['lines']}');
    print(json['lines']);
    Game game = Game(
        answer: GameAnswer.fromJson(json['answer']),
        onSuceess: (GameResult result) {},
        loadLines: json['lines']
            .map<Line>((e) => Line.fromJson(e))
            .toList()
            .cast<Line>()
            .toList());
    print('Loaded lines${game._loadLines}');
    return game;
  }

  Map toJson() {
    return {
      'answer': answer.toJson(),
      'lines': _loadLines.map((Line e) => e.toJson()).toList()
    };
  }
}

class GameResult {
  final GameAnswer answer;
  int get tries => lines.length - 1;
  bool win;
  List<Line> lines;
  String get shareMessage =>
      LocaleKeys.gameResult_share.tr(args: [answer.answer, tries.toString()]);
  GameResult({required this.win, required this.answer, this.lines = const []});
}
