import 'package:campo_minado/components/board_widget.dart';
import 'package:campo_minado/components/result_widget.dart';
import 'package:campo_minado/models/board.dart';
import 'package:campo_minado/models/explosion_exception.dart';
import 'package:campo_minado/models/field.dart';
import 'package:flutter/material.dart';

class MinefieldApp extends StatefulWidget {
  const MinefieldApp({Key? key}) : super(key: key);

  @override
  State<MinefieldApp> createState() => _MinefieldAppState();
}

class _MinefieldAppState extends State<MinefieldApp> {
  bool? _won;
  Board? _board;

  void _restart() {
    setState(() {
      _won = null;
      _board!.restart();
    });
  }

  void _openField(Field field) {
    if (_won != null) return;

    setState(() {
      try {
        field.openField();
        if (_board!.resolved) {
          _won = true;
        }
      } on ExplosionException {
        _won = false;
        _board!.revealBombs();
      }
    });
  }

  void _markingToggle(Field field) {
    if (_won != null) return;
    setState(() {
      field.markingToggle();
      if (_board!.resolved) {
        _won = true;
      }
    });
  }

  Board _getBoard(double width, double height) {
    if (_board == null) {
      int qttColumns = 15;
      double fieldSize = width / qttColumns;
      int qttRows = (height / fieldSize).floor();

      _board = Board(
        rows: qttRows,
        columns: qttColumns,
        numberOfBombs: 25,
      );
    }
    return _board!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          won: _won,
          onRestart: _restart,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return BoardWidget(
                board: _getBoard(constraints.maxWidth, constraints.maxHeight),
                onOpening: _openField,
                onToggleMarking: _markingToggle,
              );
            },
          ),
        ),
      ),
    );
  }
}
