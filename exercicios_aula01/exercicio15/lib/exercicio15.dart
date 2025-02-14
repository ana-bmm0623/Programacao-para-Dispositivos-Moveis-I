import 'dart:io';

var numeros = <int>{};

void adicionarNumero(numero) {
  numeros.add(numero);
}

void listarPares() {
  var pares = numeros.where((numero) => numero % 2 == 0);
  print(pares);
}

void lerNumeros() {
  print('Digite um numero ou "0" para encerrar:');
  int numero = -1;
  while (numero != 0) {
    numero = int.parse(stdin.readLineSync()!);
    if (numero != 0) {
      adicionarNumero(numero);
    }
  }
}
