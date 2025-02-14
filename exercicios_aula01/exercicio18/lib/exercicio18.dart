class Carro {
  String? marca;
  String? _modelo;
  int? ano;

  String? get modelo => _modelo;

  set modelo(String? modelo) {
    if (modelo != null && modelo.length < 3) {
      throw Exception('O modelo deve ter no mínimo 3 caracteres');
    }
    _modelo = modelo;
  }

  void exibirInformacoes() {
    print('Marca: $marca');
    print('Modelo: $_modelo');
    print('Ano: $ano');
  }
}
