import 'package:exercicio18/exercicio18.dart' as exercicio18;

void main(List<String> arguments) {
  var carro = exercicio18.Carro();
  carro.marca = 'Fiat';
  carro.modelo = 'Uno';
  carro.ano = 2020;

  carro.exibirInformacoes();
}
