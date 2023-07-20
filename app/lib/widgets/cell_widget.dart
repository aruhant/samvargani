import 'package:flutter/material.dart';
import 'package:paheli/models/cell.dart';

class CellWidget extends StatelessWidget {
  const CellWidget({required this.cell, super.key});
  final Cell cell;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: cell.state == CellState.empty
                ? Colors.black12
                : cell.state == CellState.correct
                    ? const Color.fromRGBO(129, 178, 154, 1)
                    : cell.state == CellState.incorrect
                        ? const Color.fromRGBO(224, 122, 95, 1)
                        : cell.state == CellState.misplaced
                            ? const Color.fromRGBO(242, 204, 143, 1)
                            : Colors.black38),
        child: Center(
          child: Text(cell.myLetter.value,
              style: const TextStyle(
                  color: Color.fromRGBO(61, 64, 91, 1), fontSize: 30)),
        ));
  }
}
