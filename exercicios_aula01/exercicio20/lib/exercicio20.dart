mixin Volante {
  void dirigir() {
    print('O veículo está sendo dirigido.');
  }
}

class Carro with Volante {
  String? marca;
  String? modelo;
  int? ano;

  void exibirInformacoes() {
    print('Marca: $marca');
    print('Modelo: $modelo');
    print('Ano: $ano');
  }
}
