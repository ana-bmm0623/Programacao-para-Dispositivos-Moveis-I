import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async {
  var url = Uri.parse('http://172.16.111.121:8080/Pessoas/cpf/1');

  try {
    var data = await consumirAPI(url);
    print('Resposta da API: $data');
  } catch (e) {
    print('Erro na requisição: $e');
  }
}

Future<dynamic> consumirAPI(Uri url) async {
  var response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Erro na requisição: ${response.statusCode}');
  }
}
