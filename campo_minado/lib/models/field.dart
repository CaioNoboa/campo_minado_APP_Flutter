import 'package:campo_minado/models/explosion_exception.dart';

class Field {
  final int row;
  final int column;
  final List<Field> neighbors = [];

  bool _opened = false;
  bool _marked = false;
  bool _minefield = false;
  bool _exploded = false;

  Field({
    required this.row,
    required this.column,
  });

  // Função para adicionar células vizinhas
  void addNeighbor(Field neighbor) {
    final deltaRow = (row - neighbor.row).abs();
    final deltaColumn = (column - neighbor.column).abs();

    if (deltaRow == 0 && deltaColumn == 0) return;

    if (deltaRow <= 1 && deltaColumn <= 1) {
      neighbors.add(neighbor);
    }
  }

  void openField() {
    if (_opened) return;

    _opened = true;

    if (_minefield) {
      _exploded = true;
      throw ExplosionException();
    }

    if (safeNeighborhood) {
      for (var element in neighbors) {
        element.openField();
      }
    }
  }

  void revealBomb() {
    if (_minefield) {
      _opened = true;
    }
  }

  void mine() {
    _minefield = true;
  }

  void markingToggle() {
    _marked = !_marked;
  }

  void restart() {
    _opened = false;
    _marked = false;
    _minefield = false;
    _exploded = false;
  }

  bool get opened {
    return _opened;
  }

  bool get marked {
    return _marked;
  }

  bool get minefield {
    return _minefield;
  }

  bool get exploded {
    return _exploded;
  }

  bool get resolved {
    bool minefieldAndMarked = minefield && marked;
    bool safeAndOpened = !minefield && opened;
    return minefieldAndMarked || safeAndOpened;
  }

  bool get safeNeighborhood {
    return neighbors.every((element) => !element.minefield);
  }

  int get numberOfMinesInTheNeighborhood {
    return neighbors.where((element) => element.minefield).length;
  }
}
