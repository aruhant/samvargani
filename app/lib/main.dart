import 'dart:math';
import 'package:flutter/material.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/models/line.dart';
import 'package:paheli/models/lines.dart';
import 'package:paheli/widgets/game_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Game game = Game();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: game.length.toString() + ' अक्षर का शब्द ढूंढें',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GameWidget(game: game),
    );
  }
}