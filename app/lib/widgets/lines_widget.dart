import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:paheli/models/lines.dart';
import 'package:paheli/widgets/line_widget.dart';

class LinesWidget extends StatelessWidget {
  const LinesWidget({required this.lines, required this.wordLength, super.key});
  final Lines lines;
  final int wordLength;
  @override
  Widget build(BuildContext context) {
    AutoSizeGroup group = AutoSizeGroup();
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var line in lines.lines) LineWidget(line: line),
        ],
      ),
    );
  }
  //   return GridView.count(
  //     shrinkWrap: true,
  //     crossAxisCount: wordLength,
  //     children: [
  //       for (var line in lines.lines)
  //         for (var cell in line.cells) CellWidget(cell: cell)
  //     ],
  //   );
  // }
}
