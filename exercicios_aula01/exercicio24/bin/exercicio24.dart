import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  var url = Uri.parse('http://172.16.91.80:8080/Pessoas');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    print('Resposta da Api: $data');
  } else {
    print('Erro na requisição: ${response.statusCode}');
  }
}
