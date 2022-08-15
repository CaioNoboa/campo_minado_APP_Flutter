import 'package:campo_minado/models/field.dart';
import 'package:flutter/material.dart';

class FieldWidget extends StatelessWidget {
  final Field field;
  final void Function(Field) onOpening; // clique curto para abrir
  final void Function(Field)
      onToggleMarking; // clique longo para marcar ou desmarcar

  const FieldWidget({
    Key? key,
    required this.field,
    required this.onOpening,
    required this.onToggleMarking,
  }) : super(key: key);

  _getImage() {
    if (field.opened && field.minefield && field.exploded) {
      return Image.asset('assets/images/bomba_0.jpeg');
    } else if (field.opened && field.minefield) {
      return Image.asset('assets/images/bomba_1.jpeg');
    } else if (field.opened) {
      return Image.asset('assets/images/aberto_${field.numberOfMinesInTheNeighborhood}.jpeg');
    } else if (field.marked) {
      return Image.asset('assets/images/bandeira.jpeg');
    } else {
      return Image.asset('assets/images/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpening(field),
      onLongPress: () => onToggleMarking(field),
      child: _getImage(),
    );
  }
}
