import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paheli/utils/string.dart';

void main() {
  testWidgets('String functions test', (WidgetTester tester) async {
    print('श्री'.characters.toList());
    print('श्री'.halfOnly);
    for (String character in 'श्री'.allCharacters) {
      print('$character ---> ${character.matra} + ${character.vyanjan}');
    }
    // write the same code but for for उन्मुक्त
    for (String character in 'उन्मुक्त'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
          '$character ---> ${character.matra} + ${character.vyanjan} + ${character.halfOnly}');
    }
  });
}
