import 'package:flutter/material.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/models/user_properties.dart';
import 'package:paheli/utils/dictionary.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/utils/string.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/line.dart';
import 'package:easy_localization/easy_localization.dart';

enum GameType {
  daily,
  practice,
  tutorial;

  static GameType fromString(String type) {
    switch (type) {
      case 'daily':
        return GameType.daily;
      case 'practice':
        return GameType.practice;
      case 'tutorial':
        return GameType.tutorial;
      default:
        return GameType.daily;
    }
  }
}

class Game {
  final GameType gameType;
  GameAnswer answer;
  final List<Line> _loadLines;
  final Function(GameResult)? onSuccess;
  final String title;
  final int id;
  final void Function(String)? onGuess;
  int get tries => lines.length - 1;
  List<Line> get lines => [
        ..._loadLines,
        Line(
            cells: List<Cell>.generate(
                answer.answer.characters.toList().length,
                (index) => Cell(
                    answer.answer.characters.toList()[index].allModifiers,
                    state: CellState.empty)))
      ];
  Game(
      {this.onSuccess,
      required this.answer,
      List<Line> loadLines = const [],
      this.onGuess,
      required this.title,
      required this.id,
      required this.gameType})
      : _loadLines = loadLines;
  Game.load(
      {this.onSuccess,
      required this.title,
      required this.id,
      required this.answer,
      this.onGuess,
      required this.gameType})
      : _loadLines =
            UserProperties.instance.loadGame('game_${answer.answer}_${id}_${gameType.toString()}')?._loadLines ?? [];
  int get length => answer.answer.characters.toList().length;
  List<String> get answerList => answer.answer.characters.toList();
  bool get complete =>
      _loadLines.isNotEmpty &&
      answer.answer == _loadLines.last.cells.map((e) => e.value).join();

  String get name => answer.answer;

  String get saveKey => 'game_${answer.answer}_${id}_${gameType.toString()}';

  String addGuess(String guess) {
    if (guess.isEmpty) return '';
    if (onGuess != null) onGuess!(guess);

    //print('guess_${tries + 1}_$name');
    //print('guess: $guess');
    if (guess.toLowerCase() == 'iddqd') return answer.answer;
    if (guess.replaceAll(' ', '').toLowerCase().startsWith('tm')) {
      String sdelta = guess.trim().toLowerCase().split(' ').last;
      int delta = int.tryParse(sdelta) ?? 0;
      UserProperties.instance.timeTravel(delta);
      return 'Time Travelled $delta';
    }
    if (guess.toLowerCase() == 'clear') {
      UserProperties.instance.clear();
      return 'Cleared';
    }
    if (guess.replaceAll(' ', '').toLowerCase() == 'warpten') {
      if (onSuccess != null) {
        onSuccess!(GameResult(
            win: true, answer: answer, lines: lines, gameType: gameType, title: title));
      }
      return answer.answer;
    }
    if (guess.endsWith('्')) {
      //return LocaleKeys.game_gameMessages_halantError.tr();
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
      guessList = guess.characters.toList();
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
      return LocaleKeys.game_gameMessages_wrongWordLength.tr(
          args: [guessList.length.toString(), answerList.length.toString()]);
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
        //print(answerList.map((e) => e.vyanjan).toList());
        if (UserProperties.instance.runCount < 5 &&
            answerList.map((e) => e.vyanjan).toList().join() == guess) {
          return LocaleKeys.game_gameMessages_addedNoMatras.tr(args: [guess]);
        }
        return LocaleKeys.game_gameMessages_notInDictonary.tr(args: [guess]);
      }
      guess = allVariations.firstWhere((element) => wordList.contains(element));
      guessList = guess.characters.toList();
    }

    List<Cell> cells = [];
    for (int i = 0; i < guessList.length; i++) {
      cells.add(Cell(guessList[i],
          state: getStateForCell(answer.answer, guessList[i], i)));
    }
    _loadLines.add(Line(cells: cells));
    UserProperties.instance.saveGame(this);
    if (answer.answer == guess && onSuccess != null) {
      onSuccess!(GameResult(
          win: true, answer: answer, lines: lines, gameType: gameType, title: title));
      return '';
    }
    if (UserProperties.instance.runCount < 5 &&
        answerList.map((e) => e.vyanjan).toList().join() == guess) {
      return LocaleKeys.game_gameMessages_addedNoMatras.tr(args: [guess]);
    }
    return UserProperties.instance.tooltipsPressed > 20
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
    print(json['gameType']);

    Game game = Game(
        answer: GameAnswer.fromJson(json['answer']),
        title:  '',
        onSuccess: (GameResult result) {},
        loadLines: toReturnLines,
        gameType: GameType.fromString(json['gameType']),
        id: json['id'] ?? -1);
    return game;
  }

  Map toJson() {
    print("SAVE${gameType.name}");
    return {
      'answer': answer.toJson(),
      'lines': _loadLines.map((Line e) => e.toJson()).toList(),
      'gameType': gameType.name
    };
  }
}

class GameResult {
  final GameAnswer answer;
  final GameType gameType;
  String title;
  int get tries => lines.length - 1;
  bool win;
  List<Line> lines;
  String get shareMessage =>
      LocaleKeys.gameResult_share.tr(args: [answer.answer, tries.toString()]);
  GameResult(
      {required this.title,
        required this.win,
      required this.answer,
      required this.gameType,
      this.lines = const []});
}

CellState getStateForCell(String answer, String guessCharacter, int index) {
  bool containsMatra = guessCharacter.matraOnly.isNotEmpty;
  bool containsAdha = guessCharacter.halfOnly.isNotEmpty;
  List<String> answerList = answer.characters.toList();
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
        if (answerList[index].matraOnly.contains(guessCharacter.matraOnly)) {
          if (answerList[index].matraOnly == guessCharacter.matraOnly) {
            return CellState.correctVyanjanWithMatraAddAdha;
          } else {
            return CellState.correctVyanjanWithMatraAddMatra;
          }
        } else {
          return CellState.correctVyanjanWithMatraRemoveMatra;
        }
      }
    } else {
      if (containsAdha) {
        if (answerList[index].halfOnly.contains(guessCharacter.halfOnly)) {
          if (answerList[index].halfOnly == guessCharacter.halfOnly) {
            return CellState.correctVyanjanWithAdhaAddMatra;
          } else {
            return CellState.correctVyanjanWithAdhaAddAdha;
          }
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
