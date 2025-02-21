import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

void main() async {
  var url = Uri.parse('http://247b-200-129-177-130.ngrok-free.app');

  try {
    var data = await getPessoas(url);
    print('Resposta da API: $data');
  } catch (e) {
    print('Erro na requisição: $e');
  }

  stdout.write('Digite o CPF a ser buscado: ');
  String cpf = stdin.readLineSync() ?? '';

  try {
    var data = await getPessoaPeloCPF(url, cpf);
    print('Resposta da API: $data');
  } catch (e) {
    print('Erro na requisição: $e');
  }

  stdout.write('Digite o nome: ');
  String nome = stdin.readLineSync() ?? '';
  stdout.write('Digite o CPF: ');
  String cpfCadastro = stdin.readLineSync() ?? '';
  stdout.write('Digite a idade: ');
  int idade = int.parse(stdin.readLineSync() ?? '0');

  try {
    var data = await cadastrarPessoa(
        url, {'nome': nome, 'cpf': cpfCadastro, 'idade': idade});
    print('Resposta da API: $data');
  } catch (e) {
    print('Erro na requisição: $e');
  }
}

Future<dynamic> getPessoas(Uri url) async {
  var response = await http.get(Uri.parse('${url.toString()}/Pessoas'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Erro na requisição: ${response.statusCode}');
  }
}

Future<dynamic> getPessoaPeloCPF(Uri url, String cpf) async {
  var response = await http.get(Uri.parse('${url.toString()}/Pessoas/cpf/$cpf'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Erro na requisição: ${response.statusCode}');
  }
}

Future<dynamic> cadastrarPessoa(Uri url, Map<String, dynamic> pessoa) async {
  var response = await http.post(Uri.parse('${url.toString()}/Pessoas'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(pessoa));

  if (response.statusCode == 201) {
    return json.decode(response.body);
  } else {
    throw Exception('Erro na requisição: ${response.statusCode}');
  }
}
