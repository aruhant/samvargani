import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paheli/utils/string.dart';
import 'package:paheli/models/game.dart';

void main() {
  testWidgets('String functions test', (WidgetTester tester) async {
    print("प्रामाणिक".characters.toList());
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
