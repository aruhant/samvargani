import 'package:flutter/material.dart';
import 'package:paheli/models/lines.dart';
import 'package:paheli/widgets/lines_widget.dart';

class GameWidget extends StatelessWidget {
  const GameWidget({required this.lines, super.key});
  final Lines lines;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LinesWidget(lines: lines));
  }
}
