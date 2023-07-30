import 'package:flutter/material.dart';

class GameAnswer {
  final String answer;
  final String meaning;
  final List<String?>? hints;
  final Color? backgroundColor;
  final List<IconData>? icons;
  final List<String>? images;
  final AxisDirection direction;
  GameAnswer({
    required this.answer,
    required this.meaning,
    this.hints,
    this.backgroundColor = Colors.cyan,
    this.icons = const [
      Icons.cloud,
      Icons.cloud_circle_outlined,
      Icons.airplanemode_active,
    ],
    this.images,
    this.direction = AxisDirection.right,
  });
}

final List<GameAnswer> gameAnswers = [
  GameAnswer(answer: 'श्रृंगार', meaning: 'सजाने की क्रिया या भाव'),
  GameAnswer(answer: 'उत्सुकता', meaning: 'उत्साह'),
  GameAnswer(answer: 'साहसिक', meaning: 'बहादुर'),
  GameAnswer(answer: 'विचित्र', meaning: 'अनोखा'),
  GameAnswer(answer: 'उमंग', meaning: 'उत्साह'),
  GameAnswer(answer: 'प्रचंड', meaning: 'बहुत अधिक'),
  GameAnswer(answer: 'मुस्कान', meaning: 'हँसी'),
  GameAnswer(answer: 'स्नेह', meaning: 'प्रेम'),
  GameAnswer(answer: 'बेख़बर', meaning: 'अनजान'),
  GameAnswer(answer: 'धैर्य', meaning: 'साहस')
];
