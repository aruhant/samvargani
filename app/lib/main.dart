import 'package:flutter/material.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/line.dart';
import 'package:paheli/models/lines.dart';
import 'package:paheli/widgets/game_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paheli',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GameWidget(lines: testLines()),
    );
  }
}

Lines testLines() {
  return Lines(lines: [
    Line(cells: [
      Cell('1', state: CellState.correct),
      Cell('2', state: CellState.correct),
      Cell('3', state: CellState.correct),
      Cell('4', state: CellState.correct),
      Cell('5', state: CellState.correct)
    ]),
    Line(
      cells: [
        Cell('6', state: CellState.correct),
        Cell('7', state: CellState.correct),
        Cell('8', state: CellState.correct),
        Cell('9', state: CellState.correct),
        Cell('10', state: CellState.correct)
      ],
    ),
    Line(
      cells: [
        Cell('11', state: CellState.correct),
        Cell('12', state: CellState.correct),
        Cell('13', state: CellState.correct),
        Cell('14', state: CellState.correct),
        Cell('15', state: CellState.correct)
      ],
    ),
    Line(
      cells: [
        Cell('16', state: CellState.correct),
        Cell('17', state: CellState.correct),
        Cell('18', state: CellState.correct),
        Cell('19', state: CellState.correct),
        Cell('20', state: CellState.correct)
      ],
    )
  ]);
}
