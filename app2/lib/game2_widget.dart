
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hindi/models/matrix.dart';

const GRID_SIZE = 100;

class Game2Widget extends StatefulWidget {
  const Game2Widget({super.key, required this.matrices});
  final List<WordMatrix> matrices;
  @override
  State<Game2Widget> createState() => Game2WidgetState();
}

class Game2WidgetState extends State<Game2Widget> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        InteractiveViewer(
                          constrained: false,
                          child: GridPaper(
                            interval: GRID_SIZE.toDouble(),
                            divisions: 1,
                            subdivisions: 1,
                            color: Colors.red,
                            child: SizedBox(
                              width: 40.0 * GRID_SIZE,
                              height: 40.0 * GRID_SIZE,
                              child: Stack(
                                children: widget.matrices
                                    .map((e) => makeWidget(e))
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 0,
                          top: 0,
                          child: Text('Toolbars'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );

  Widget makeWidget(WordMatrix e) {
    return Positioned(
      top: e.rect.top * GRID_SIZE.toDouble(),
      left: e.rect.left * GRID_SIZE.toDouble(),
      child: MatrixWidget(
        matrix: e,
        onDrag: (offset) => setState(() => e.offset = offset),
      ),
    );
  }
}

class MatrixWidget extends StatefulWidget {
  const MatrixWidget({super.key, required this.matrix, required this.onDrag});
  final WordMatrix matrix;
  final Function(Offset) onDrag;
  @override
  State<MatrixWidget> createState() => MatrixWidgetState();
}

class MatrixWidgetState extends State<MatrixWidget> {
  @override
  Widget build(BuildContext context) {
    print(
        'width: ${widget.matrix.rect.width * GRID_SIZE.toDouble()}, height: ${widget.matrix.rect.height * GRID_SIZE.toDouble()}');
    return GestureDetector(
      onPanEnd: (details) {
        setState(() {
          final offset = Offset(widget.matrix.rect.left.roundToDouble(),
              widget.matrix.rect.top.roundToDouble());
          widget.onDrag(offset);
        });
      },
      onPanUpdate: (details) {
        setState(() {
          final offset = Offset(
              widget.matrix.rect.left + details.delta.dx / GRID_SIZE,
              widget.matrix.rect.top + details.delta.dy / GRID_SIZE);
          widget.onDrag(offset);
        });
      },
      child: Container(
        width: widget.matrix.rect.width * GRID_SIZE.toDouble(),
        height: widget.matrix.rect.height * GRID_SIZE.toDouble(),
        color: Colors.black38,
        child: Stack(
          children: widget.matrix.map.entries
              .map((e) => Positioned(
                    top: e.key.$2 * GRID_SIZE.toDouble(),
                    left: e.key.$1 * GRID_SIZE.toDouble(),
                    child: Container(
                        height: GRID_SIZE.toDouble(),
                        width: GRID_SIZE.toDouble(),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          e.value,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 100, color: Colors.black87),
                        )),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
