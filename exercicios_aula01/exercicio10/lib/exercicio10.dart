import 'dart:io';

Map<String, int> cadastro = {};

void adicionarCadastro() {
  bool condicao = true;
  while (condicao) {
    print('Digite o nome do cadastro:');
    String nome = stdin.readLineSync()!;
    print('Digite a idade do cadastro:');
    int idade = int.parse(stdin.readLineSync()!);
    cadastro[nome] = idade;
    print('Deseja adicionar outro cadastro? (s/n)');
    String resposta = stdin.readLineSync()!;
    if (resposta != "s") {
      condicao = false;
    }
  }
}
