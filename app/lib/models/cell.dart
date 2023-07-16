enum CellState { correct, incorrect, empty, misplaced }

class Cell {
  Cell(this.value, {this.state = CellState.empty});
  String value = '';
  CellState state = CellState.empty;
}
