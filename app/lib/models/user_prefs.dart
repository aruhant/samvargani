import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paheli/models/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  final bool _darkMode;
  int _initState;
  int _practiceGameIndex;
  final SharedPreferences _sharedPrefs;
  UserPrefs(
      {required bool darkMode,
      required int initState,
      required int practiceGameIndex,
      required String currentPracticeGame,
      required String currentDailyGame,
      required SharedPreferences sharedPrefs})
      : _initState = initState,
        _darkMode = darkMode,
        _practiceGameIndex = practiceGameIndex,
        _sharedPrefs = sharedPrefs;

  static UserPrefs? _instance;
  static UserPrefs get instance => _instance!;
  bool get darkMode => _darkMode;
  bool get shouldShowHelp => _initState < 2;
  bool get shouldShowLocaleSettings => _initState < 1;
  int get practiceGameIndex => _practiceGameIndex;

  get language => null;

  static Future<UserPrefs> init() async {
    if (_instance == null) {
      WidgetsFlutterBinding.ensureInitialized();
      var sharedPrefs = await SharedPreferences.getInstance();
      _instance = UserPrefs(
          practiceGameIndex: sharedPrefs.getInt('progress') ?? 0,
          darkMode: sharedPrefs.getBool('darkMode') ?? false,
          initState: sharedPrefs.getInt('initState') ?? 0,
          currentPracticeGame: sharedPrefs.getString('practiceGame') ?? '{}',
          currentDailyGame: sharedPrefs.getString('dailyGame') ?? '{}',
          sharedPrefs: sharedPrefs);
    }
    return _instance!;
  }

  firstRunDone() {
    _instance!._initState = 2;
    _sharedPrefs.setInt('initState', _instance!._initState);
  }

  localeSet() {
    _instance!._initState = 1;
    _sharedPrefs.setInt('initState', _instance!._initState);
  }

  bool makeProgress(int max) {
    if (_instance!._practiceGameIndex == max - 1) {
      return false;
    }
    _instance!._practiceGameIndex++;
    _sharedPrefs.setInt('progress', _instance!._practiceGameIndex);
    return true;
  }

  saveGame(Game game) {
    String s = jsonEncode(game.toJson());
    print('------LOAD--------');
    print(s);
    _sharedPrefs.setString('game_${game.name}', s);
  }

  save() {
    _sharedPrefs.setBool('darkMode', _instance!._darkMode);
    _sharedPrefs.setInt('progress', _instance!._practiceGameIndex);
  }

  Game? loadGame(String name) {
    var game = _sharedPrefs.getString('game_$name');
    print('------LOAD--------');
    print(game);
    if (game != null) return Game.fromJson(jsonDecode(game));
    return null;
  }
}
