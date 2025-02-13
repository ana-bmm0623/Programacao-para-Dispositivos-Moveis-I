import 'dart:io';

import 'package:exercicio6/exercicio6.dart' as exercicio6;

void main(List<String> arguments) {
  stdout.write('Digite o dia da semana: ');
  var diaDaSemana = stdin.readLineSync();
  exercicio6.lembrete(diaDaSemana);
}
