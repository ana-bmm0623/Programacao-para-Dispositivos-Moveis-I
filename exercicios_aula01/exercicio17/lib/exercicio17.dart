class Carro {
  String marca;
  String modelo;
  int ano;

  Carro(this.marca, this.modelo, this.ano);

  void exibirInformacoes() {
    print('Dados do Carro:');
    print('Marca: $marca');
    print('Modelo: $modelo');
    print('Ano: $ano');
  }
}
