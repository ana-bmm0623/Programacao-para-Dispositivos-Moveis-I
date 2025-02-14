import 'package:test/test.dart';
import 'package:exercicio11/exercicio11.dart';

void main() {
  test('soma de 1 e 2 deve ser 3', () {
    expect(soma(1, 2), 3);
  });

  test('soma de 0 e 0 deve ser 0', () {
    expect(soma(0, 0), 0);
  });

  test('soma de -1 e -1 deve ser -2', () {
    expect(soma(-1, -1), -2);
  });

  test('soma de 100 e 200 deve ser 300', () {
    expect(soma(100, 200), 300);
  });

  test('soma de -50 e 50 deve ser 0', () {
    expect(soma(-50, 50), 0);
  });
}