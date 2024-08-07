import 'package:paheli/utils/dictionary.dart';
import 'package:paheli/utils/string.dart';

void main() {
  for (final word in wordList) {
    if (word.allCharacters.length == 2 &&
        word.allCharacters[0].matra.isEmpty &&
        word.allCharacters[1].matra.isEmpty &&
        // ends with r
        word.endsWith('र')) {
      print(word);
    }
  }

  // print('ढ़'.contains('़'));
  // print('टढ़ड़ा'.getAllVaraitions);

  /*
  for (String character in 'क़'.allCharacters) {
    print(
        // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
        '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly}+ ${character.matra}');
  }
  // for
  print('------------------');
  for (String character in 'क़'.allCharacters) {
    print(
        // '${character.runes.map((e) => Char(e))} ---> ${character.matra} + ${character.vyanjan}');
        '$character ---> ${character.matraOnly} + ${character.vyanjan} + ${character.halfOnly}+ ${character.matra}');
  }
  print('------------------');

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
  }
  */
  // test toJson of answer
  /*final anAnswer = GameAnswer(
        answer: 'a',
        meaning: 'a',
        images: [],
        backgroundColor: const Color.fromARGB(2, 2, 2, 2),
        colors: [Colors.black12],
        icons: [LineIcons.handshake]);
    final json = anAnswer.toJson();

    print(json);

    print('----------------------');
    final fromJson = GameAnswer.fromJson(json);
    print('----------------------');
    print(fromJson.toJson());*/
/*
    Line line = Line(cells: [
      Cell('a', state: CellState.misplaced),
      Cell('b', state: CellState.misplaced),
      Cell('c', state: CellState.misplacedVyanjan),
      Cell('d', state: CellState.correctVyanjan),
    ]);
    Game game = Game(
        onSuceess: (p0) {},
        answer: GameAnswer(
            answer: 'a',
            meaning: 'a',
            images: [],
            backgroundColor: const Color.fromARGB(2, 2, 2, 2),
            colors: [Colors.black12],
            icons: [LineIcons.handshake]),
        loadLines: [line]);
    Map s = line.toJson();
    print(s);
    Line l = Line.fromJson(jsonDecode(jsonEncode(s)));
    print(l.toJson());
    print('----------------------');
    print(game.toJson());
    print('----------------------');
    print(Game.fromJson(jsonDecode(jsonEncode(game.toJson()))).toJson());*/
}
