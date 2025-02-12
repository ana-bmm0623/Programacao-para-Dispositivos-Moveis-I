import 'dart:io';

import 'package:exercicio5/exercicio5.dart' as exercicio5;

void main(List<String> arguments) {
  stdout.write('Digite um número: ');
  var numero = int.parse(stdin.readLineSync()!);
  print(exercicio5.verificarParImpar(numero));
}
