import 'package:flutter/material.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/models/user_prefs.dart';
import 'package:paheli/utils/dictionary.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/utils/string.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Game {
  GameAnswer answer;
  final List<Line> _loadLines;
  final Function(GameResult)? onSuceess;
  int get tries => lines.length - 1;
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
  Game({this.onSuceess, required this.answer, List<Line> loadLines = const []})
      : _loadLines = loadLines;
  Game.load({this.onSuceess, required this.answer})
      : _loadLines =
            UserPrefs.instance.loadGame(answer.answer)?._loadLines ?? [];
  int get length => answer.answer.allCharacters.length;
  List<String> get answerList => answer.answer.allCharacters;
  bool get complete =>
      _loadLines.isNotEmpty &&
      answer.answer == _loadLines.last.cells.map((e) => e.value).join();

  String get name => answer.answer;

  String addGuess(String guess) {
    FirebaseAnalytics.instance.logEvent(name: 'guess_${tries + 1}_$name');
    if (guess.toLowerCase() == 'iddqd') return answer.answer;
    if (guess.toLowerCase() == 'clear') {
      UserPrefs.instance.clear();
      return 'Cleared';
    }
    if (guess.replaceAll(' ', '').toLowerCase() == 'warpten') {
      if (onSuceess != null) {
        onSuceess!(GameResult(win: true, answer: answer, lines: lines));
      }
      return answer.answer;
    }
    guess = guess
        .replaceAll('क़', 'क़')
        .replaceAll('ख़', 'ख़')
        .replaceAll('ग़', 'ग़')
        .replaceAll('ज़', 'ज़')
        .replaceAll('ड़', 'ड़')
        .replaceAll('ढ़', 'ढ़')
        .replaceAll('फ़', 'फ़')
        .replaceAll('य़', 'य़');

    List<String> guessList = guess.allCharacters;

    if ('ा	िी	ु	ू	ृ	ॄ	ॅ	ॆ	े	ै	ॉ	ॊ	ो	ौ'.contains(guessList[0])) {
      return LocaleKeys.game_gameMessages_matraError.tr(args: [guessList[0]]);
    }
    if (guessList.contains('अो')) {
      return LocaleKeys.game_gameMessages_aoError.tr();
    }
    if (guessList.contains('अौ')) {
      return LocaleKeys.game_gameMessages_auError.tr();
    }

    if (length != guessList.length) {
      return LocaleKeys.game_gameMessages_wrongWordLength
          .tr(args: [guessList.length.toString()]);
    }
    if ((_loadLines
            .map((e) => e.cells.map((e) => e.value).toList().join())
            .toList())
        .contains(guess)) {
      return LocaleKeys.game_gameMessages_alreadyGuessed.tr();
    }

    if (/* !kDebugMode &&  */ guess != answer.answer &&
        !wordList.contains(guess)) {
      final allVariations = guess.getAllVaraitions;
      if (!allVariations.any((element) => wordList.contains(element))) {
        return LocaleKeys.game_gameMessages_notInDictonary.tr(args: [guess]);
      }
      guess = allVariations.firstWhere((element) => wordList.contains(element));
      guessList = guess.allCharacters;
    }

    List<Cell> cells = [];
    for (int i = 0; i < guessList.length; i++) {
      cells.add(Cell(guessList[i],
          state: getStateForCell(answer.answer, guessList[i], i)));
    }
    _loadLines.add(Line(cells: cells));
    UserPrefs.instance.saveGame(this);
    if (answer.answer == guess && onSuceess != null) {
      onSuceess!(GameResult(win: true, answer: answer, lines: lines));
      return '';
    }
    return UserPrefs.instance.tooltipsPressed > 6
        ? ''
        : LocaleKeys.game_gameMessages_incorrect.tr();
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
    Game game = Game(
        answer: GameAnswer.fromJson(json['answer']),
        onSuceess: (GameResult result) {},
        loadLines: json['lines']
            .map<Line>((e) => Line.fromJson(e))
            .toList()
            .cast<Line>()
            .toList());
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
