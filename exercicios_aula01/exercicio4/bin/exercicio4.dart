import 'dart:io';

import 'package:exercicio4/exercicio4.dart' as exercicio4;

void main(List<String> arguments) {
  stdout.write('Digite um double para se converter em int: ');
  stdin.readLineSync();
  var num1 = double.parse(stdin.readLineSync()!);
  print(
      'O double $num1 convertido em int é: ${exercicio4.parseDoubleToInt(num1)}');
  stdout.write('Digite um int para se converter em double: ');
  stdin.readLineSync();
  var num2 = int.parse(stdin.readLineSync()!);
  print('O int $num2 convertido em double é: ${exercicio4.parseIntToDouble(num2)}');
}
