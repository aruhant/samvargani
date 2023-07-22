import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paheli/utils/string.dart';
import 'package:paheli/models/game.dart';

void main() {
  testWidgets('String functions test', (WidgetTester tester) async {
    print('श्री'.characters.toList());
    print('श्री'.allCharacters);
    for (String character in 'श्री'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
          '${character} ---> ${character.matra} + ${character.vyanjan}');
    }
    print("पत्ता".characters.toList());
    print("पत्ता".allCharacters);
    for (String character in 'पत्ता'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
          '${character} ---> ${character.matra} + ${character.vyanjan}');
    }
    print("प्रसन्न".characters.toList());
    print("प्रसन्न".allCharacters);
    for (String character in 'प्रसन्न'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
          '${character} ---> ${character.matra} + ${character.vyanjan}');
    }
    for (String word in words) {
      print('--------------\n$word');
      for (String character in word.allCharacters) {
        print(
            // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
            '${character} ---> ${character.matra} + ${character.vyanjan}');
      }
    }
  });
}
