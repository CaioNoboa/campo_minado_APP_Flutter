import 'package:campo_minado/models/field.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Campo', () {
    test('Abrir campo COM explosão', () {
      Field field = Field(row: 0, column: 0);
      field.mine();

      expect(field.openField, throwsException);
    });
    test('Abrir campo SEM explosão', () {
      Field field = Field(row: 0, column: 0);
      field.openField();

      expect(field.opened, true);
    });
    test('Adicionar NÃO vizinho', () {
      Field fieldA = Field(row: 0, column: 0);
      Field fieldB = Field(row: 1, column: 3);
      fieldA.addNeighbor(fieldB);

      expect(fieldA.neighbors.isEmpty, true);
    });
    test('Adicionar vizinho', () {
      Field fieldA = Field(row: 3, column: 3);
      Field fieldB = Field(row: 3, column: 4);
      Field fieldC = Field(row: 2, column: 2);
      Field fieldD = Field(row: 4, column: 4);
      fieldA.addNeighbor(fieldB);
      fieldA.addNeighbor(fieldC);
      fieldA.addNeighbor(fieldD);

      expect(fieldA.neighbors.length, 3);
    });
    test('Minas na vizinhança', () {
      Field fieldA = Field(row: 3, column: 3);
      Field fieldB = Field(row: 3, column: 4);
      fieldB.mine();
      Field fieldC = Field(row: 2, column: 2);
      Field fieldD = Field(row: 4, column: 4);
      fieldD.mine();

      fieldA.addNeighbor(fieldB);
      fieldA.addNeighbor(fieldC);
      fieldA.addNeighbor(fieldD);

      expect(fieldA.numberOfMinesInTheNeighborhood, 2);
    });
  });
}
