import 'package:paheli/models/cell.dart';

class Line {
  Line({required this.cells});
  List<Cell> cells = [];
  get length => cells.length;
}
