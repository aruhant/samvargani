import 'package:paheli/models/line.dart';

class Lines {
  Lines({required this.lines});
  List<Line> lines;
  int get wordLength => lines[0].length;

  void addLine(Line line) {
    lines.add(line);
  }
}
