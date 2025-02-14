import 'package:exercicio20/exercicio20.dart' as exercicio20;

void main(List<String> arguments) {
  var carro = exercicio20.Carro()
    ..marca = 'Chevrolet'
    ..modelo = 'Onix'
    ..ano = 2021;

  carro.exibirInformacoes();
  carro.dirigir();
}
