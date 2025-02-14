import 'dart:io';

import 'package:exercicio11/exercicio11.dart' as exercicio11;

void main(List<String> arguments) {
  stdout.write('Digite o primeiro número: ');
  var numero1 = int.parse(stdin.readLineSync()!);
  stdout.write('Digite o segundo número: ');
  var numero2 = int.parse(stdin.readLineSync()!);
  print(
      'A soma de $numero1 e $numero2 é: ${exercicio11.soma(numero1, numero2)}');
}
