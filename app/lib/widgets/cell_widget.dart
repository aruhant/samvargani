import 'package:flutter/material.dart';
import 'package:paheli/models/cell.dart';

class CellWidget extends StatelessWidget {
  const CellWidget({required this.cell, super.key});
  final Cell cell;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: cell.state == CellState.empty
              ? Colors.white
              : cell.state == CellState.correct
                  ? Colors.green
                  : cell.state == CellState.incorrect
                      ? Colors.red
                      : Colors.yellow),
      child: Text(cell.myLetter.value,
          style: TextStyle(
              color: cell.state == CellState.correct
                  ? Colors.black
                  : cell.state == CellState.incorrect
                      ? Colors.grey
                      : Colors.blueGrey,
              fontSize: 20)),
    );
  }
}
