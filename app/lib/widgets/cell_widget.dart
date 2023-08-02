import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:paheli/models/cell.dart';

class CellWidget extends StatelessWidget {
  const CellWidget({required this.cell, super.key, required this.group});
  final AutoSizeGroup group;
  final Cell cell;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Tooltip(
          showDuration: const Duration(seconds: 10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5))
              ]),
          triggerMode: TooltipTriggerMode.tap,
          textStyle: const TextStyle(color: Colors.white),
          message: cell.state.tooltip(cell.myLetter.value),
          child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: cell.state.color),
              child: Center(
                  child: AutoSizeText(cell.myLetter.value,
                      group: group,
                      maxLines: 1,
                      maxFontSize: 10000,
                      minFontSize: 1,
                      style: const TextStyle(
                          color: Color.fromRGBO(61, 64, 91, 1),
                          fontSize: 10000)))),
        ),
      ),
    );
  }
}
