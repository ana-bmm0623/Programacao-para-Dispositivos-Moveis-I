import 'package:exercicio2/exercicio2.dart';
import 'package:test/test.dart';

void main() {
  test('Teste 1', () {
    expect(nome, 'João');
    expect(idade, 20);
    expect(altura, 1.80);
    expect(estudante, true);
  });
}
