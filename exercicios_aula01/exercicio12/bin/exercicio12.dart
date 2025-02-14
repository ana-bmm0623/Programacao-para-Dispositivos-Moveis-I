import 'dart:io';

import 'package:exercicio12/exercicio12.dart' as exercicio12;

void main(List<String> arguments) {
  stdout.write('Digite o seu nome: ');
  String? entrada = stdin.readLineSync();
  String mensagem;

  if (entrada == null || entrada.isEmpty) {
    mensagem = exercicio12.saudacao();
  } else {
    mensagem = exercicio12.saudacao(nome: entrada);
  }

  print(mensagem);
}
