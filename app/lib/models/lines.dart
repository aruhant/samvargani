import 'package:paheli/models/line.dart';

class Lines {
  Lines({required this.lines});
  List<Line> lines;

  void addLine(Line line) {
    lines.add(line);
  }
}
