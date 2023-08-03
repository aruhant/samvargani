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
  final double maxOpacity, minOpacity, maxSize, minSize, maxSpeed, minSpeed;
  final int itemsCount;
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
    this.maxOpacity = 0.4,
    this.minOpacity = 0.15,
    this.maxSize = 30,
    this.minSize = 150,
    this.maxSpeed = 0.4,
    this.minSpeed = 0.25,
    this.itemsCount = 6,
  });
}

final List<GameAnswer> gameAnswers = [
  GameAnswer(
      answer: 'वृष्टि',
      meaning: 'बारिश',
      icons: [LineIcons.frog],
      moveHorizontal: false,
      moveVertical: true,
      colors: [Colors.green],
      backgroundColor: Colors.green[100]),
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
      moveHorizontal: false,
      moveVertical: true,
      colors: [Colors.orange[100]!],
      backgroundColor: Colors.blue[100]),
  GameAnswer(
      answer: 'स्पन्दन',
      meaning: 'कंपन',
      icons: [LineIcons.heartbeat],
      moveHorizontal: true,
      moveVertical: false,
      colors: const [Colors.red],
      backgroundColor: Colors.red[100]),
  GameAnswer(
    answer: 'व्यसान',
    meaning: 'लत',
    icons: [LineIcons.smoking],
    moveHorizontal: false,
    moveVertical: true,
    colors: [Colors.yellow[200]!],
    backgroundColor: Colors.yellow[100],
  ),
  GameAnswer(
      answer: 'दृष्टि',
      meaning: 'निगाह, देखने की शक्ति',
      icons: [LineIcons.eye, LineIcons.eyeAlt],
      moveHorizontal: true,
      moveVertical: false,
      colors: [Colors.black12],
      backgroundColor: Colors.amber[100]),
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
      icons: [LineIcons.lightningBolt],
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
      meaning: 'ठेस का लाक्षणिक प्रयोग।',
      icons: [
        LineIcons.exclamationTriangle,
        LineIcons.lightningBolt,
        LineIcons.skullCrossbones
      ],
      moveHorizontal: true,
      moveVertical: true,
      colors: const [Color.fromARGB(255, 211, 121, 94)],
      backgroundColor: const Color.fromARGB(255, 178, 178, 212)),
  GameAnswer(
    answer: 'तीव्र',
    meaning: 'तेज़, अत्यंत',
    icons: [LineIcons.horse],
    moveHorizontal: true,
    moveVertical: false,
    colors: [Colors.pink[100]!],
    backgroundColor: Colors.pink[50],
    maxSpeed: 5,
    minSpeed: 0.4,
  ),
  GameAnswer(
      answer: 'माणिक',
      meaning: 'एक अनमोल रत्न।',
      icons: [LineIcons.gem],
      moveHorizontal: false,
      moveVertical: true,
      colors: const [Color.fromARGB(255, 232, 112, 97)],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
      answer: 'अँगूठा',
      meaning: 'हाथ अथवा पैर की पहली और सबसे मोटी उँगली।',
      icons: [LineIcons.hands],
      moveHorizontal: false,
      moveVertical: true,
      colors: const [Color.fromARGB(255, 229, 180, 179)],
      backgroundColor: const Color.fromARGB(255, 241, 228, 252)),
  GameAnswer(
      answer: 'नक़द',
      meaning: 'वह धन जो रुपया-पैसा, सिक्का आदि के रूप में हो',
      icons: [LineIcons.moneyBill],
      moveHorizontal: false,
      moveVertical: true,
      colors: const [Color.fromARGB(255, 188, 229, 140)],
      backgroundColor: const Color.fromARGB(255, 241, 228, 252)),
  GameAnswer(
      answer: 'मुकुट',
      meaning: 'ताज',
      icons: [LineIcons.chessKing],
      moveHorizontal: false,
      moveVertical: true,
      colors: const [Color.fromARGB(255, 255, 255, 255)],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
      answer: 'विस्फोट',
      meaning: 'फूटकर बाहर निकलना',
      icons: [LineIcons.bomb],
      moveHorizontal: false,
      moveVertical: true,
      colors: [
        const Color.fromARGB(255, 233, 96, 96),
        const Color.fromARGB(255, 74, 53, 51)
      ],
      backgroundColor: const Color.fromARGB(255, 241, 228, 252)),
  GameAnswer(
    answer: 'औषधि',
    meaning: 'प्राकृतिक दवा',
    icons: [LineIcons.cannabis, LineIcons.mortarPestle, LineIcons.pills],
    moveHorizontal: false,
    moveVertical: true,
    colors: const [Color.fromARGB(255, 190, 230, 103)],
    backgroundColor: const Color.fromARGB(255, 33, 168, 3),
  ),
  GameAnswer(
    answer: 'विद्या',
    meaning: 'ज्ञान',
    icons: [LineIcons.book, LineIcons.school],
    moveHorizontal: false,
    moveVertical: true,
    colors: [Colors.pink[100]!],
    backgroundColor: Colors.pink[50],
  ),
  GameAnswer(
    answer: 'बलवान',
    meaning: 'शक्तिशाली',
    icons: [LineIcons.dumbbell, LineIcons.raisedFist],
    moveHorizontal: false,
    moveVertical: true,
    colors: const [Color.fromARGB(255, 229, 180, 179)],
    backgroundColor: const Color.fromARGB(255, 241, 228, 252),
  ),
  GameAnswer(
      answer: 'स्नेह',
      meaning: 'प्रेम',
      icons: [LineIcons.heart],
      moveHorizontal: false,
      moveVertical: true,
      colors: [Colors.pink[100]!],
      backgroundColor: Colors.pink[50]),
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
