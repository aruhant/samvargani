import 'package:flutter/material.dart';
import 'package:paheli/models/lines.dart';
import 'package:paheli/widgets/cell_widget.dart';
import 'package:paheli/widgets/line_widget.dart';

class LinesWidget extends StatelessWidget {
  const LinesWidget({required this.lines, super.key});
  final Lines lines;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: lines.wordLength,
      children: [
        for (var l in lines.lines)
          for (var c in l.cells) CellWidget(cell: c)
      ],
    );
  }
}
