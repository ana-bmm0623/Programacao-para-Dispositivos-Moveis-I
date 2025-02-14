import 'dart:io';

var listaDeFrutas = <String>{};

void adicionarFruta(fruta) {
  listaDeFrutas.add(fruta);
}

void lerFrutas() {
  print('Digite o nome de uma fruta ou "sair" para encerrar:');
  var fruta = '';
  while (fruta != 'sair') {
    fruta = stdin.readLineSync()!;
    if (fruta != 'sair') {
      adicionarFruta(fruta);
    }
  }
}

void imprimirListaDeFrutas(listaDeFrutas) {
  print(listaDeFrutas);
}
