import 'dart:io';

import 'package:exercicio13/exercicio13.dart' as exercicio13;

void main(List<String> arguments) {
  stdout.write('Digite o valor de a: ');
  var a = int.parse(stdin.readLineSync()!);
  print('O valor do fatorial de $a é: ${exercicio13.calcularFatorial(a)}');
}
