import 'dart:convert';

import 'package:http/http.dart' as http;

void consumirAPI() async {
  var url = Uri.parse(
      'http://247b-200-129-177-130.ngrok-free.app/swagger/index.html');

  try {
    var data = await getPessoas(url);
    print('Resposta da API: $data');
  } catch (e) {
    print('Erro na requisição: $e');
  }
}

Future<dynamic> getPessoas(Uri url) async {
  var response = await http.get('$url/Pessoas' as Uri);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Erro na requisição: ${response.statusCode}');
  }
}
