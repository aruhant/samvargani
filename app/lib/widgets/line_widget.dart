import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:paheli/models/line.dart';
import 'package:paheli/widgets/cell_widget.dart';

class LineWidget extends StatelessWidget {
  const LineWidget({required this.line, super.key, required this.group});
  final Line line;
  final AutoSizeGroup group;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: line.cells
          .map<Widget>((e) => CellWidget(cell: e, group: group))
          .toList(),
    );
  }
}
