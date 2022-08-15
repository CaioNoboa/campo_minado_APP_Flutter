import 'package:campo_minado/components/field_widget.dart';
import 'package:campo_minado/models/board.dart';
import 'package:campo_minado/models/field.dart';
import 'package:flutter/material.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final void Function(Field) onOpening;
  final void Function(Field) onToggleMarking;

  const BoardWidget({
    Key? key,
    required this.board,
    required this.onOpening,
    required this.onToggleMarking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: board.columns,
        children: board.fields.map((field) {
          return FieldWidget(
            field: field,
            onOpening: onOpening,
            onToggleMarking: onToggleMarking,
          );
        }).toList(),
      ),
    );
  }
}
