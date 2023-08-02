import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class GameAnswer {
  final String answer;
  final String meaning;
  final List<String?>? hints;
  final Color? backgroundColor;
  final List<Color> colors;
  final List<IconData> icons;
  final List<String>? images;
  final bool moveHorizontal, moveVertical;
  GameAnswer({
    required this.answer,
    required this.meaning,
    this.hints,
    this.colors = const [Colors.white, Colors.blue],
    this.backgroundColor = const Color.fromARGB(255, 180, 207, 229),
    this.icons = const [LineIcons.cloud, LineIcons.star],
    this.images,
    this.moveHorizontal = true,
    this.moveVertical = false,
  });
}

final List<GameAnswer> gameAnswers = [
  GameAnswer(
      answer: 'स्नेह',
      meaning: 'प्रेम',
      icons: [LineIcons.heart],
      moveHorizontal: false,
      moveVertical: true,
      colors: [Colors.pink[100]!],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
      answer: 'वृष्टि',
      meaning: 'बारिश',
      icons: [LineIcons.frog],
      moveHorizontal: false,
      moveVertical: true,
      colors: [Colors.blue, Colors.cyan],
      backgroundColor: Colors.blue[100]),
  GameAnswer(
      answer: 'वारिद',
      meaning: 'बारिश',
      icons: [LineIcons.cloud],
      moveHorizontal: true,
      moveVertical: false,
      colors: [Colors.blue, Colors.cyan],
      backgroundColor: Colors.blue[100]),
  GameAnswer(
      answer: 'दरिया',
      meaning: 'समुद्र या नदी',
      icons: [LineIcons.fish],
      moveHorizontal: true,
      moveVertical: false,
      colors: [Colors.orangeAccent, Colors.yellowAccent],
      backgroundColor: Colors.blue[100]),
  GameAnswer(
      answer: 'धड़कन',
      meaning: 'हृदय का स्पन्दन',
      icons: [LineIcons.heartbeat],
      moveHorizontal: true,
      moveVertical: false,
      colors: const [
        Color.fromRGBO(221, 107, 107, 1),
        Color.fromARGB(255, 214, 106, 142)
      ],
      backgroundColor: const Color.fromARGB(255, 167, 203, 130)),
  GameAnswer(
    answer: 'व्यसान',
    meaning: 'लत',
    icons: [LineIcons.smoking],
    moveHorizontal: false,
    moveVertical: true,
    colors: [Colors.yellow[200]!, Colors.yellow[200]!],
    backgroundColor: Colors.yellow[100],
  ),
  GameAnswer(
      answer: 'नयन',
      meaning: 'आँख',
      icons: [LineIcons.eye, LineIcons.eyeAlt],
      moveHorizontal: true,
      moveVertical: false,
      colors: [Colors.black12, Colors.black26],
      backgroundColor: Color.fromARGB(255, 207, 237, 240)),
  GameAnswer(
      answer: 'सेहत',
      meaning: 'स्वास्थ्य',
      icons: [LineIcons.fruitApple],
      moveHorizontal: false,
      moveVertical: true,
      colors: [Colors.red, Colors.lightGreen],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
      answer: 'चंचला',
      meaning: 'बिजली',
      icons: [LineIcons.bolt],
      moveHorizontal: false,
      moveVertical: true,
      colors: [Colors.pink[100]!],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
      answer: 'झोंका',
      meaning: 'वेगपूर्वक चलने वाली हवा',
      icons: [LineIcons.wind],
      moveHorizontal: true,
      moveVertical: false,
      colors: [Colors.grey, Colors.blueGrey, Colors.black12],
      backgroundColor: Colors.blue[200]),
  GameAnswer(
      answer: 'झटका',
      meaning: 'ठेस का लाक्षणिक प्रयोग',
      icons: [LineIcons.heart],
      moveHorizontal: true,
      moveVertical: true,
      colors: [Colors.pink[100]!],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
      answer: 'तीव्र',
      meaning: 'तेज़, अत्यंत',
      icons: [LineIcons.horse],
      moveHorizontal: true,
      moveVertical: false,
      colors: [Colors.pink[100]!],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
      answer: 'विश्वास',
      meaning: 'भरोसा',
      icons: [LineIcons.heart],
      moveHorizontal: false,
      moveVertical: true,
      colors: [Colors.pink[100]!],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
      answer: 'विश्वास',
      meaning: 'भरोसा',
      icons: [LineIcons.heart],
      moveHorizontal: false,
      moveVertical: true,
      colors: [Colors.pink[100]!],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
      answer: 'विश्वास',
      meaning: 'भरोसा',
      icons: [LineIcons.heart],
      moveHorizontal: false,
      moveVertical: true,
      colors: [Colors.pink[100]!],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
      answer: 'विश्वास',
      meaning: 'भरोसा',
      icons: [LineIcons.heart],
      moveHorizontal: false,
      moveVertical: true,
      colors: [Colors.pink[100]!],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
      answer: 'विश्वास',
      meaning: 'भरोसा',
      icons: [LineIcons.heart],
      moveHorizontal: false,
      moveVertical: true,
      colors: [Colors.pink[100]!],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
    answer: 'विश्वास',
    meaning: 'भरोसा',
    icons: [LineIcons.heart],
    moveHorizontal: false,
    moveVertical: true,
    colors: [Colors.pink[100]!],
    backgroundColor: Colors.pink[50],
  ),
  GameAnswer(
    answer: 'विश्वास',
    meaning: 'भरोसा',
    icons: [LineIcons.heart],
    moveHorizontal: false,
    moveVertical: true,
    colors: [Colors.pink[100]!],
    backgroundColor: Colors.pink[50],
  ),
  GameAnswer(
    answer: 'विश्वास',
    meaning: 'भरोसा',
    icons: [LineIcons.heart],
    moveHorizontal: false,
    moveVertical: true,
    colors: [Colors.pink[100]!],
    backgroundColor: Colors.pink[50],
  ),
  GameAnswer(answer: 'श्रृंगार', meaning: 'सजाने की क्रिया या भाव'),
  GameAnswer(answer: 'उत्सुकता', meaning: 'उत्साह'),
  GameAnswer(answer: 'साहसिक', meaning: 'बहादुर'),
  GameAnswer(answer: 'विचित्र', meaning: 'अनोखा'),
  GameAnswer(answer: 'उमंग', meaning: 'उत्साह'),
  GameAnswer(answer: 'प्रचंड', meaning: 'बहुत अधिक'),
  GameAnswer(answer: 'मुस्कान', meaning: 'हँसी'),
  GameAnswer(answer: 'बेख़बर', meaning: 'अनजान'),
  GameAnswer(answer: 'धैर्य', meaning: 'साहस'),
  GameAnswer(answer: 'विश्वास', meaning: 'भरोसा'),
];
