import 'package:test/test.dart';
import 'package:exercicio14/exercicio14.dart';

void main() {
  setUp(() {
    numeros.clear();
  });

  test('Adicionar número à lista', () {
    adicionarNumero(5);
    expect(numeros, [5]);
  });

  test('Ordenar números na lista', () {
    adicionarNumero(3);
    adicionarNumero(1);
    adicionarNumero(2);
    ordenarNumeros();
    expect(numeros, [1, 2, 3]);
  });

  test('Adicionar e ordenar números', () {
    adicionarNumero(10);
    adicionarNumero(5);
    adicionarNumero(8);
    ordenarNumeros();
    expect(numeros, [5, 8, 10]);
  });

  test('Lista vazia após clear', () {
    adicionarNumero(7);
    numeros.clear();
    expect(numeros, []);
  });
}