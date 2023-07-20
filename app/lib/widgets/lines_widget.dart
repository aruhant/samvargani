import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:paheli/models/line.dart';
import 'package:paheli/widgets/line_widget.dart';

class LinesWidget extends StatelessWidget {
  const LinesWidget({required this.lines, required this.wordLength, super.key});
  final List<Line> lines;
  final int wordLength;
  @override
  Widget build(BuildContext context) {
    AutoSizeGroup group = AutoSizeGroup();
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var line in lines) LineWidget(line: line, group: group),
        ],
      ),
    );
  }
}
