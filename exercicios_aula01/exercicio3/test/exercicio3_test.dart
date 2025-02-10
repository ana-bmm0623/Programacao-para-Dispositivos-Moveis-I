import 'package:exercicio3/exercicio3.dart';
import 'package:test/test.dart';

void main() {
  test('Testa se a função retorna o valor correto', () {
    expect(soma(1, 2), 3);
    expect(soma(2, 2), 4);
    expect(soma(3, 2), 5);
    expect(soma(4, 2), 6);
    expect(soma(5, 2), 7);
  });
}
