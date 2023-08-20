import 'package:paheli/models/cell.dart';

class Line {
  Line({required this.cells});
  List<Cell> cells = [];
  get length => cells.length;
  

  static Line fromJson(Map<String, dynamic> json) {
    return Line(
        cells: List<Cell>.from(json['cells'].map((e) => Cell.fromJson(e))));
  }

  Map<String, dynamic> toJson() {
    return {
      'cells': cells.map((e) => e.toJson()).toList(),
    };
  }
}
