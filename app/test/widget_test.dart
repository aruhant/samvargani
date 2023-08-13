import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/utils/string.dart';

void main() {
  testWidgets('String functions test', (WidgetTester tester) async {
    /*
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
    print('------------------');
    // परिप्रेक्ष्य

    for (String character in 'परिप्रेक्ष्क'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
          '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly} + ${character.matra}');
    }
    // do the same for श्रेष्ठतम, सर्वश्रेष्ठ, उत्कृष्ट
    print('------------------');
    for (String character in 'श्रेष्ठतम'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
          '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly} + ${character.matra}');
    }
    print('------------------');
    for (String character in 'सर्वश्रेष्ठ'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
          '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly} + ${character.matra}');
    }
    print('------------------');
    for (String character in 'उत्कृष्ट'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
          '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly} + ${character.matra}');
    }
    // do the same for शृंगार

    print('------------------');
    for (String character in 'शृंगार'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
          '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly} + ${character.matra} ');
    }
    // श्रृंगार
    print('------------------');
    for (String character in 'श्रृंगार'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');

          '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly} + ${character.matra} ');
    }
    //चिह्न
    print('------------------');
    for (String character in 'चिह्न'.allCharacters) {
      //print(character.runes.map((e) => String.fromCharCode(e)).toList());

      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');

          '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly} + ${character.matra} ');
    }
    // मुद्रित
    print('------------------');
    for (String character in 'मुद्रित'.allCharacters) {
      //print(character.runes.map((e) => String.fromCharCode(e)).toList());

      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');

          '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly} + ${character.matra} ');
    }
    // पञ्चमाक्षर
    print('------------------');
    for (String character in 'पञ्चमाक्षर'.allCharacters) {
      print(
          // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');

          '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly} + ${character.matra} ');
    }*/
    // test toJson of answer
    final anAnswer = GameAnswer(
        answer: 'a',
        meaning: 'a',
        images: [],
        backgroundColor: Color.fromARGB(2, 2, 2, 2),
        colors: [Colors.black12],
        icons: [LineIcons.handshake]);
    final json = anAnswer.toJson();

    print(json);

    print('----------------------');
    final fromJson = GameAnswer.fromJson(json);
    print('----------------------');
    print(fromJson.toJson());

    //end (add curly braces and parenthesis where required )
  });
}
