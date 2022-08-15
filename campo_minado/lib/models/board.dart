import 'dart:math';
import 'package:campo_minado/models/field.dart';

class Board {
  final int rows;
  final int columns;
  final int numberOfBombs;

  final List<Field> _fields = [];

  Board({
    required this.rows,
    required this.columns,
    required this.numberOfBombs,
  }) {
    _createFields();
    _relateNeighbors();
    _raffleMinefield();
  }

  void restart() {
    for (var field in _fields) {
      field.restart();
    }
    _raffleMinefield();
  }

  void revealBombs() {
    for (var field in _fields) {
      field.revealBomb();
    }
  }

  void _createFields() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        _fields.add(Field(row: i, column: j));
      }
    }
  }

  void _relateNeighbors() {
    for (var field in _fields) {
      for (var neighbor in _fields) {
        field.addNeighbor(neighbor);
      }
    }
  }

  void _raffleMinefield() {
    int raffled = 0;

    if (numberOfBombs > rows * columns) return;

    while (raffled < numberOfBombs) {
      int i = Random().nextInt(_fields.length);

      if (!_fields[i].minefield) {
        raffled++;
        _fields[i].mine();
      }
    }
  }

  List<Field> get fields {
    return _fields;
  }

  bool get resolved {
    return _fields.every((field) => field.resolved);
  }
}
