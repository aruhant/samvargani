import 'package:flutter/material.dart';
import 'package:paheli/models/lines.dart';
import 'package:paheli/widgets/cell_widget.dart';

class LinesWidget extends StatelessWidget {
  const LinesWidget({required this.lines, super.key});
  final Lines lines;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: lines.wordLength,
      children: [
        for (var line in lines.lines)
          for (var cell in line.cells) CellWidget(cell: cell)
      ],
    );
  }
}
