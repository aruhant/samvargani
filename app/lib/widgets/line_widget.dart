import 'package:flutter/material.dart';
import 'package:paheli/models/line.dart';
import 'package:paheli/widgets/cell_widget.dart';

class LineWidget extends StatelessWidget {
  const LineWidget({required this.line, super.key});
  final Line line;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: line.cells.map<Widget>((e) => CellWidget(cell: e)).toList(),
      ),
    );
  }
}
