import 'package:paheli/models/cell.dart';
import 'package:paheli/models/line.dart';

class Lines {
  Lines({required this.lines});
  List<Line> lines;
  int get wordLength => lines[0].length;

  int get totalCells => lines.length * wordLength;
  Cell atIndex(int i) => lines[wordLength ~/ i].cells[wordLength % i];
}
