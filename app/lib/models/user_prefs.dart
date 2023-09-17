import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paheli/models/game.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class UserPrefs {
  final bool _darkMode;
  int _initState;
  int _runCount;
  int _practiceGameIndex;
  int _tooltipsPressed;
  final SharedPreferences _sharedPrefs;
  UserPrefs(
      {required bool darkMode,
      required int initState,
      required int practiceGameIndex,
      required int runCount,
      required SharedPreferences sharedPrefs,
      required int tooltipsPressed})
      : _initState = initState,
        _darkMode = darkMode,
        _practiceGameIndex = practiceGameIndex,
        _sharedPrefs = sharedPrefs,
        _runCount = runCount,
        _tooltipsPressed = tooltipsPressed;

  static UserPrefs? _instance;
  static UserPrefs get instance => _instance!;
  bool get darkMode => _darkMode;
  bool get shouldShowHelp => _initState < 2;
  bool get shouldShowLocaleSettings => _initState < 1;
  int get practiceGameIndex => _practiceGameIndex;
  int get tooltipsPressed => _tooltipsPressed;
  int get runCount => _runCount;

  get language => null;

  static Future<UserPrefs> init() async {
    if (_instance == null) {
      WidgetsFlutterBinding.ensureInitialized();
      var sharedPrefs = await SharedPreferences.getInstance();
      _instance = UserPrefs(
          practiceGameIndex: sharedPrefs.getInt('progress') ?? 0,
          darkMode: sharedPrefs.getBool('darkMode') ?? false,
          initState: sharedPrefs.getInt('initState') ?? 0,
          runCount: sharedPrefs.getInt('runCount') ?? 0,
          tooltipsPressed: sharedPrefs.getInt('tooltipsPressed') ?? 0,
          sharedPrefs: sharedPrefs);
    }
    return _instance!;
  }

  firstRunDone() {
    _instance!._initState = 2;
    _sharedPrefs.setInt('initState', _instance!._initState);
  }

  increaseRunCount() {
    _instance!._runCount++;
    _sharedPrefs.setInt('runCount', _instance!._runCount);
  }

  localeSet() {
    _instance!._initState = 1;
    _sharedPrefs.setInt('initState', _instance!._initState);
  }

  bool makeProgress(int max) {
    if (_instance!._practiceGameIndex == max - 1) {
      return false;
    }
    if (practiceGameIndex != 0) {
      FirebaseAnalytics.instance
          .logLevelEnd(levelName: '${_instance!._practiceGameIndex + 1}');
    }
    _instance!._practiceGameIndex++;
    FirebaseAnalytics.instance.setUserProperty(
        name: 'level', value: '${_instance!._practiceGameIndex + 1}');
    if (practiceGameIndex != 1) {
      FirebaseAnalytics.instance
          .logLevelStart(levelName: '${_instance!._practiceGameIndex + 1}');
    }
    _sharedPrefs.setInt('progress', _instance!._practiceGameIndex);
    return true;
  }

  saveGame(Game game) {
    String s = jsonEncode(game.toJson());
    _sharedPrefs.setString('game_${game.name}', s);
  }

  onTooltipPressed() {
    print('ttp ${_instance!._tooltipsPressed}');
    _instance!._tooltipsPressed++;
    _sharedPrefs.setInt('tooltipsPressed', _instance!._tooltipsPressed);
  }

  save() {
    _sharedPrefs.setBool('darkMode', _instance!._darkMode);
    _sharedPrefs.setInt('progress', _instance!._practiceGameIndex);
  }

  Game? loadGame(String name) {
    var game = _sharedPrefs.getString('game_$name');
    if (game != null) return Game.fromJson(jsonDecode(game));
    return null;
  }

  clear() => _sharedPrefs.clear();
}
