import 'package:flutter/material.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/models/user_prefs.dart';
import 'package:paheli/utils/dictionary.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/utils/string.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/line.dart';
import 'package:easy_localization/easy_localization.dart';

class Game {
  GameAnswer answer;
  final List<Line> _loadLines;
  final Function(GameResult)? onSuceess;

  final void Function(String)? onGuess;
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
  Game(
      {this.onSuceess,
      required this.answer,
      List<Line> loadLines = const [],
      this.onGuess})
      : _loadLines = loadLines;
  Game.load({this.onSuceess, required this.answer, this.onGuess})
      : _loadLines =
            UserPrefs.instance.loadGame(answer.answer)?._loadLines ?? [];
  int get length => answer.answer.allCharacters.length;
  List<String> get answerList => answer.answer.allCharacters;
  bool get complete =>
      _loadLines.isNotEmpty &&
      answer.answer == _loadLines.last.cells.map((e) => e.value).join();

  String get name => answer.answer;

  String addGuess(String guess) {
    print("ttp");
    print(UserPrefs.instance.tooltipsPressed);
    if (guess.isEmpty) return '';
    if (onGuess != null) onGuess!(guess);

    print('guess_${tries + 1}_$name');
    print('guess: $guess');
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
    if (guess.endsWith('्')) {
      return LocaleKeys.game_gameMessages_halantError.tr();
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
    List<String> guessList = [];
    try {
      guessList = guess.allCharacters;
    } catch (e) {
      return LocaleKeys.game_gameMessages_halantError.tr();
    }

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
    return UserPrefs.instance.tooltipsPressed > 20
        ? ''
        : LocaleKeys.game_gameMessages_incorrect.tr();
  }

  static Game fromJson(Map json) {
    List<Line> toReturnLines = [];
    for (final Map<String, dynamic> line in json['lines']) {
      List<Cell> cells = [];
      for (int i = 0; i < line['cells']!.length; i++) {
        cells.add(Cell(line['cells']![i]['value'],
            state: getStateForCell(
                json['answer']['answer'], line['cells']![i]['value'], i)));
      }
      toReturnLines.add(Line(cells: cells));
    }

    Game game = Game(
        answer: GameAnswer.fromJson(json['answer']),
        onSuceess: (GameResult result) {},
        loadLines: toReturnLines);

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

CellState getStateForCell(String answer, String guessCharacter, int index) {
  bool containsMatra = guessCharacter.matraOnly.isNotEmpty;
  bool containsAdha = guessCharacter.halfOnly.isNotEmpty;
  List<String> answerList = answer.allCharacters;
  if (answerList[index] == guessCharacter) {
    return CellState.correct;
  } else if (answerList[index].vyanjan == guessCharacter.vyanjan) {
    if (containsMatra) {
      if (containsAdha) {
        if (answerList[index].matraOnly == guessCharacter.matraOnly) {
          return CellState.correctVyanjanWithMatraAndAdhaRemoveAdha;
        } else if (answerList[index].halfOnly == guessCharacter.halfOnly) {
          return CellState.correctVyanjanWithMatraAndAdhaRemoveMatra;
        } else {
          return CellState.correctVyanjanWithMatraAndAdhaRemoveMatraAndAdha;
        }
      } else {
        if (answerList[index].matraOnly == guessCharacter.matraOnly) {
          return CellState.correctVyanjanWithMatraAddAdha;
        } else {
          return CellState.correctVyanjanWithMatraRemoveMatra;
        }
      }
    } else {
      if (containsAdha) {
        if (answerList[index].halfOnly == guessCharacter.halfOnly) {
          return CellState.correctVyanjanWithAdhaAddMatra;
        } else {
          return CellState.correctVyanjanWithAdhaRemoveAdha;
        }
      } else {
        if ((answerList[index]).matraOnly.isNotEmpty) {
          if (answerList[index].halfOnly.isNotEmpty) {
            return CellState.correctVyanjanWithoutMatraAndAdhaAddMatraAndAdha;
          } else {
            return CellState.correctVyanjanWithoutMatraAndAdhaAddMatra;
          }
        } else {
          return CellState.correctVyanjanWithoutMatraAndAdhaAddAdha;
        }
      }
    }
  } else if (answerList.contains(guessCharacter)) {
    return CellState.misplaced;
  } else if (answerList
      .map((e) => e.vyanjan)
      .contains(guessCharacter.vyanjan)) {
    String toCompare = answerList[answerList
        .map((e) => e.vyanjan)
        .toList()
        .indexOf(guessCharacter.vyanjan)];
    if (containsMatra) {
      if (containsAdha) {
        if (toCompare.matraOnly == guessCharacter.matraOnly) {
          return CellState.misplacedVyanjanWithMatraAndAdhaRemoveAdha;
        } else if (toCompare.halfOnly == guessCharacter.halfOnly) {
          return CellState.misplacedVyanjanWithMatraAndAdhaRemoveMatra;
        } else {
          return CellState.misplacedVyanjanWithMatraAndAdhaRemoveMatraAndAdha;
        }
      } else {
        if (toCompare.matraOnly == guessCharacter.matraOnly) {
          return CellState.misplacedVyanjanWithMatraAddAdha;
        } else {
          return CellState.misplacedVyanjanWithMatraRemoveMatra;
        }
      }
    } else {
      if (containsAdha) {
        if (toCompare.halfOnly == guessCharacter.halfOnly) {
          return CellState.misplacedVyanjanWithAdhaAddMatra;
        } else {
          return CellState.misplacedVyanjanWithAdhaRemoveAdha;
        }
      } else {
        if (toCompare.matraOnly.isNotEmpty) {
          if (toCompare.halfOnly.isNotEmpty) {
            return CellState.misplacedVyanjanWithoutMatraAndAdhaAddMatraAndAdha;
          } else {
            return CellState.misplacedVyanjanWithoutMatraAndAdhaAddMatra;
          }
        } else {
          return CellState.misplacedVyanjanWithoutMatraAndAdhaAddAdha;
        }
      }
    }
  } else {
    if (answerList
        .any((element) => element.halfOnly.contains(guessCharacter.vyanjan))) {
      return CellState.incorrectButContainsAdha;
    } else {
      return CellState.incorrect;
    }
  }
}
