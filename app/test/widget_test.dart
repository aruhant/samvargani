import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paheli/utils/string.dart';

void main() {
  testWidgets('String functions test', (WidgetTester tester) async {
    // do the same for सामर्थ्य

    for (String character in 'सामर्थ्य'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
          '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly}+ ${character.matra}');
    }
    print('------------------');
    // do the same for अर्थशास्त्र
    for (String character in 'अर्थशास्त्र'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
          '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly}+ ${character.matra}');
    }
    print('------------------');
    for (String character in 'उत्सुक'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
          '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly} + ${character.matra}');
    }
    print('अर्थशास्त्र'.allCharacters.toList());

    print('------------------');
    for (String character in 'त्रिशूल'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
          '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly} + ${character.matra}');
    }
    // do the same for स्री
    print('------------------');
    for (String character in 'स्त्री'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
          '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly} + ${character.matra}');
    }
    print('स्त्री'.contains('त्र'));
    print('------------------');
    // परिप्रेक्ष्य
    for (String character in 'परिप्रेक्ष्य'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
          '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly} + ${character.matra}');
    }
  });
}
