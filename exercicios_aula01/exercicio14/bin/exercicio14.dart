import 'dart:io';
import 'package:exercicio14/exercicio14.dart' as exercicio14;

void main(List<String> arguments) {
  int numero;
  do {
    stdout.write('Digite um número ou "0" para encerrar: ');
    numero = int.parse(stdin.readLineSync()!);
    if (numero != 0) {
      exercicio14.adicionarNumero(numero);
    }
  } while (numero != 0);

  exercicio14.ordenarNumeros();
}
