import 'package:flutter/material.dart';
import 'package:paheli/models/lines.dart';
import 'package:paheli/widgets/line_widget.dart';

class LinesWidget extends StatelessWidget {
  const LinesWidget({required this.lines, super.key});
  final Lines lines;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: lines.lines.map<Widget>((e) => LineWidget(line: e)).toList(),
      ),
    );
  }
}
