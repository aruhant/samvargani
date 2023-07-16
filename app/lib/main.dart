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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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
