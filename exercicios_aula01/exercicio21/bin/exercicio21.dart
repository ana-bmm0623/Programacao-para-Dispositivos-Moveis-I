void main() async {
  Future meuFuturo = Future(() {
    print('Executando um Future');
    return 10;
  }).then((value) => print('Valor de retorno $value'));

  await Future.delayed(Duration(seconds: 10));

  print('Fim da execução');
}
