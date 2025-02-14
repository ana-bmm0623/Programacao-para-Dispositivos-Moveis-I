import 'package:exercicio10/exercicio10.dart';
import 'package:test/test.dart';

void main() {
  test('Testa adicionarCadastro', () {
    adicionarCadastro();
    expect(cadastro, {'João': 20, 'Maria': 30});
  });
}
