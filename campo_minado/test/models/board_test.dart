import 'package:campo_minado/models/board.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('Ganhar jogo', () {
    Board board = Board(
      rows: 2,
      columns: 2,
      numberOfBombs: 0,
    );

    board.fields[0].mine();
    board.fields[3].mine();

    // Jogando...
    board.fields[0].markingToggle();
    board.fields[1].openField();
    board.fields[2].openField();
    board.fields[3].markingToggle();

    expect(board.resolved, true);
  });
}
