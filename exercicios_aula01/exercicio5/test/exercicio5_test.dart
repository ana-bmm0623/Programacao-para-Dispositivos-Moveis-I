import 'package:exercicio5/exercicio5.dart';
import 'package:test/test.dart';

void main() {
  test('Testa se o número é par', () {
    expect(verificarParImpar(2), 'O número 2 é par');
  });

  test('Testa se o número é ímpar', () {
    expect(verificarParImpar(3), 'O número 3 é ímpar');
  });
}
