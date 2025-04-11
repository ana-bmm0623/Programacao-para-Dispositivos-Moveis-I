import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/objeto.dart';

class RestfulApiService {
  static const String baseUrl =
      "https://67f90f17094de2fe6ea0502f.mockapi.io/tecnstore/gadgets";

  // GET: Obter todos os objetos
  Future<List<Objeto>> getObjetos() async {
    final response = await http.get(Uri.parse(baseUrl));
    print("GET Objetos -> Status: ${response.statusCode}");
    print("Response: ${response.body}");
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((obj) => Objeto.fromJson(obj)).toList();
    } else {
      throw Exception("Falha ao carregar objetos: ${response.statusCode}");
    }
  }

  // POST: Criar um novo objeto
  Future<Objeto> createObjeto(Objeto objeto) async {
    final jsonBody = jsonEncode(objeto.toJson());
    print("Enviando JSON: $jsonBody");
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonBody,
    );
    print("POST Objeto -> Status: ${response.statusCode}");
    print("Response: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Objeto.fromJson(json.decode(response.body));
    } else {
      throw Exception("Falha ao criar objeto: ${response.statusCode}");
    }
  }

  // PUT: Atualizar um objeto existente
  Future<Objeto> updateObjeto(String id, Objeto objeto) async {
    final jsonBody = jsonEncode(objeto.toJson());
    print("Enviando PUT JSON: $jsonBody");
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonBody,
    );
    print("PUT Objeto -> Status: ${response.statusCode}");
    print("Response: ${response.body}");
    if (response.statusCode == 200) {
      return Objeto.fromJson(json.decode(response.body));
    } else {
      throw Exception("Falha ao atualizar objeto: ${response.statusCode}");
    }
  }

  // DELETE: Excluir um objeto pelo id
  Future<void> deleteObjeto(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    print("DELETE Objeto -> Status: ${response.statusCode}");
    if (response.statusCode != 200) {
      throw Exception("Falha ao excluir objeto: ${response.statusCode}");
    }
  }
}
