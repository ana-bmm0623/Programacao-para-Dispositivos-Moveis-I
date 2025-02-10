import 'dart:io';

import 'package:exercicio3/exercicio3.dart' as exercicio3;

void main(List<String> arguments) {
  stdout.write('Digite o primeiro número: ');
  var num1 = int.parse(stdin.readLineSync()!);
  stdout.write('Digite o segundo número: ');
  var num2 = int.parse(stdin.readLineSync()!);

  print('A soma de $num1 e $num2 é: ${exercicio3.soma(num1, num2)}');
  print('A subtração de $num1 e $num2 é: ${exercicio3.subtracao(num1, num2)}');
  print('A multiplicação de $num1 e $num2 é: ${exercicio3.multiplicacao(num1, num2)}');
  print('A divisão de $num1 e $num2 é: ${exercicio3.divisao(num1, num2)}');
}
