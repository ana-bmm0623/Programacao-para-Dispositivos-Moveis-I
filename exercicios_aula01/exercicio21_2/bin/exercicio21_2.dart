void main() async {
  int valor = 0;
  valor = await executaAlgoDemorado();
  print('Valor: $valor');
  print('Fim da Execução');
}

Future<int> executaAlgoDemorado() async {
  print('Executando algo demorado');
  Future.delayed(Duration(seconds: 5));
  print('Finalizando algo demorado');
  return 100;
}
