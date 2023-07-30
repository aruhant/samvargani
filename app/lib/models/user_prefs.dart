import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  bool _darkMode;
  bool _firstRun;
  SharedPreferences _sharedPrefs;
  UserPrefs(
      {required bool darkMode,
      required bool firstRun,
      required SharedPreferences sharedPrefs})
      : _firstRun = firstRun,
        _darkMode = darkMode,
        _sharedPrefs = sharedPrefs;

  static UserPrefs? _instance;
  static UserPrefs get instance => _instance!;
  bool get darkMode => _darkMode;
  bool get firstRun => _firstRun;

  static Future<UserPrefs> init() async {
    if (_instance == null) {
      WidgetsFlutterBinding.ensureInitialized();
      var sharedPrefs = await SharedPreferences.getInstance();
      _instance = UserPrefs(
          darkMode: sharedPrefs.getBool('darkMode') ?? false,
          firstRun: sharedPrefs.getBool('firstRun') ?? true,
          sharedPrefs: sharedPrefs);
    }
    return _instance!;
  }

  firstRunDone() {
    _instance!._firstRun = false;
    _instance!.save();
  }

  save() {
    _sharedPrefs.setBool('darkMode', _instance!._darkMode);
    _sharedPrefs.setBool('firstRun', _instance!._firstRun);
  }
}
