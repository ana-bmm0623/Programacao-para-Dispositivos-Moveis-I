import 'package:exercicio13/exercicio13.dart';
import 'package:test/test.dart';

void main() {
  test('Teste 1', () {
    expect(calcularFatorial(0), 1);
  });

  test('Teste 2', () {
    expect(calcularFatorial(1), 1);
  });

  test('Teste 3', () {
    expect(calcularFatorial(2), 2);
  });

  test('Teste 4', () {
    expect(calcularFatorial(3), 6);
  });

  test('Teste 5', () {
    expect(calcularFatorial(4), 24);
  });

  test('Teste 6', () {
    expect(calcularFatorial(5), 120);
  });

  test('Teste 7', () {
    expect(calcularFatorial(6), 720);
  });

  test('Teste 8', () {
    expect(calcularFatorial(7), 5040);
  });

  test('Teste 9', () {
    expect(calcularFatorial(8), 40320);
  });

  test('Teste 10', () {
    expect(calcularFatorial(9), 362880);
  });

  test('Teste 11', () {
    expect(calcularFatorial(10), 3628800);
  });
}
