import 'dart:io';

import 'package:exercicio16/exercicio16.dart' as exercicio16;

void main() {
  stdout.write('Digite o numerador: ');
  num numerador = num.parse(stdin.readLineSync()!);
  stdout.write('Digite o denominador: ');
  num denominador = num.parse(stdin.readLineSync()!);

  try {
    num resultado = exercicio16.dividir(numerador, denominador);
    print('Resultado: $resultado');
  } catch (e) {
    print('Erro: $e');
  }
}
