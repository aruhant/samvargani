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
      colors: [Colors.pink, Colors.red],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
      answer: 'वृष्टि',
      meaning: 'बारिश',
      icons: [LineIcons.cloud],
      moveHorizontal: true,
      moveVertical: false,
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
    answer: 'व्यसान',
    meaning: 'लत',
    icons: [LineIcons.smoking],
    moveHorizontal: true,
    moveVertical: false,
    colors: [Colors.orangeAccent, Colors.yellowAccent],
    backgroundColor: Colors.blue[100],
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
];
