import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ListaComprasApp());
}

class ListaComprasApp extends StatelessWidget {
  const ListaComprasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ListaHotelsScaffold(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          elevation: 4,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Tela principal que exibe a lista de hotéis e permite cadastrar/atualizar
class ListaHotelsScaffold extends StatefulWidget {
  const ListaHotelsScaffold({super.key});

  @override
  _ListaHotelsScaffoldState createState() => _ListaHotelsScaffoldState();
}

class _ListaHotelsScaffoldState extends State<ListaHotelsScaffold> {
  final HotelApiService apiService = HotelApiService();
  List<Hotel> _hotels = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarHoteles();
  }

  void _carregarHoteles() async {
    try {
      final hotels = await apiService.getHotels();
      setState(() {
        _hotels = hotels;
        _isLoading = false;
      });
    } catch (e) {
      print("Erro ao carregar hotéis: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Método para adicionar um novo hotel
  void _adicionarHotel() async {
    final novoHotelRecebido = await Navigator.push<Hotel>(
      context,
      MaterialPageRoute(builder: (context) => const FormularioHotelScaffold()),
    );
    if (novoHotelRecebido != null) {
      try {
        final novoHotel = await apiService.createHotel(novoHotelRecebido);
        setState(() {
          _hotels.add(novoHotel);
        });
      } catch (e) {
        print("Erro ao criar hotel: $e");
      }
    }
  }

  // Método para atualizar um hotel existente
  void _atualizarHotel(int index) async {
    final hotelAtual = _hotels[index];
    // Verifica se o hotel tem um id reservado (por exemplo, "4")
    if (hotelAtual.id == "4") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Este hotel é reservado e não pode ser editado."),
        ),
      );
      return;
    }
    final hotelAtualizado = await Navigator.push<Hotel>(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioHotelScaffold(hotel: hotelAtual),
      ),
    );
    if (hotelAtualizado != null) {
      try {
        final resultado = await apiService.updateHotel(
          hotelAtual.id!,
          hotelAtualizado,
        );
        setState(() {
          _hotels[index] = resultado;
        });
      } catch (e) {
        print("Erro ao atualizar hotel: $e");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Falha ao atualizar hotel: $e")));
      }
    }
  }

  // Método para confirmar exclusão
  Future<bool?> _confirmarExclusao() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmar Exclusão"),
          content: const Text("Tem certeza que deseja excluir este hotel?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Excluir", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Hotéis')),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: () async {
                  _carregarHoteles();
                },
                child: ListView.builder(
                  itemCount: _hotels.length,
                  itemBuilder: (context, index) {
                    return ItemHotel(
                      hotel: _hotels[index],
                      onUpdate: () => _atualizarHotel(index),
                      onDelete: () async {
                        // Verifica se o hotel é reservado
                        if (_hotels[index].id == "4") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Este hotel é reservado e não pode ser excluído.",
                              ),
                            ),
                          );
                          return;
                        }
                        bool? confirm = await _confirmarExclusao();
                        if (confirm == true) {
                          try {
                            await apiService.deleteHotel(_hotels[index].id!);
                            setState(() {
                              _hotels.removeAt(index);
                            });
                          } catch (e) {
                            print("Erro ao excluir hotel: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Erro ao excluir hotel: $e"),
                              ),
                            );
                          }
                        }
                      },
                    );
                  },
                ),
              ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarHotel,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Widget que exibe cada hotel em um Card com botões de atualizar e excluir
class ItemHotel extends StatelessWidget {
  final Hotel hotel;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const ItemHotel({
    required this.hotel,
    required this.onDelete,
    required this.onUpdate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: const Icon(Icons.hotel, color: Colors.indigo, size: 32),
        title: Text(
          hotel.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          "${hotel.address}\n${hotel.city}, ${hotel.state} - ${hotel.zipCode}\nQuartos: ${hotel.numberRooms}" +
              (hotel.phone != null ? "\nTelefone: ${hotel.phone}" : "") +
              (hotel.description != null ? "\n${hotel.description}" : ""),
          style: const TextStyle(fontSize: 14),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange, size: 28),
              onPressed: onUpdate,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red, size: 28),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

// Modelo representando um hotel
class Hotel {
  final String? id;
  final String name;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final int numberRooms;
  final String? phone;
  final String? description;

  Hotel({
    this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.numberRooms,
    this.phone,
    this.description,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipCode: json['zipCode'] ?? '',
      numberRooms:
          json['numberRooms'] is int
              ? json['numberRooms']
              : int.tryParse(json['numberRooms']?.toString() ?? "0") ?? 0,
      phone: json['phone'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'numberRooms': numberRooms,
      'phone': phone,
      'description': description,
    };
  }
}

// Serviço para consumir os endpoints CRUD dos hotéis
class HotelApiService {
  // Ajuste o baseUrl conforme o endpoint disponível no seu MockAPI
  static const String baseUrl =
      "https://67f7c0862466325443ea8c20.mockapi.io/hotelApi";

  // GET: Obter todos os hotéis
  Future<List<Hotel>> getHotels() async {
    final response = await http.get(Uri.parse(baseUrl));
    print("GET Hotels -> Status: ${response.statusCode}");
    print("Response: ${response.body}");
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((obj) => Hotel.fromJson(obj)).toList();
    } else {
      throw Exception("Falha ao carregar hotéis: ${response.statusCode}");
    }
  }

  // POST: Criar um novo hotel
  Future<Hotel> createHotel(Hotel hotel) async {
    final jsonBody = jsonEncode(hotel.toJson());
    print("Enviando JSON (POST): $jsonBody");
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonBody,
    );
    print("POST Hotel -> Status: ${response.statusCode}");
    print("Response: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Hotel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Falha ao criar hotel: ${response.statusCode}");
    }
  }

  // PUT: Atualizar um hotel existente
  Future<Hotel> updateHotel(String id, Hotel hotel) async {
    final jsonBody = jsonEncode(hotel.toJson());
    print("Enviando JSON (PUT): $jsonBody");
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonBody,
    );
    print("PUT Hotel -> Status: ${response.statusCode}");
    print("Response: ${response.body}");
    if (response.statusCode == 200) {
      return Hotel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Falha ao atualizar hotel: ${response.statusCode}");
    }
  }

  // DELETE: Excluir um hotel pelo id
  Future<void> deleteHotel(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    print("DELETE Hotel -> Status: ${response.statusCode}");
    if (response.statusCode != 200) {
      throw Exception("Falha ao excluir hotel: ${response.statusCode}");
    }
  }
}

// Tela de formulário para cadastro ou atualização de um hotel
class FormularioHotelScaffold extends StatelessWidget {
  final Hotel? hotel;

  const FormularioHotelScaffold({super.key, this.hotel});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(
      text: hotel?.name ?? '',
    );
    final TextEditingController addressController = TextEditingController(
      text: hotel?.address ?? '',
    );
    final TextEditingController cityController = TextEditingController(
      text: hotel?.city ?? '',
    );
    final TextEditingController stateController = TextEditingController(
      text: hotel?.state ?? '',
    );
    final TextEditingController zipCodeController = TextEditingController(
      text: hotel?.zipCode ?? '',
    );
    final TextEditingController numberRoomsController = TextEditingController(
      text: hotel != null ? hotel!.numberRooms.toString() : '',
    );
    final TextEditingController phoneController = TextEditingController(
      text: hotel?.phone ?? '',
    );
    final TextEditingController descriptionController = TextEditingController(
      text: hotel?.description ?? '',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          hotel == null ? 'Cadastro de Hotel' : 'Atualização de Hotel',
        ),
        backgroundColor: Colors.grey.shade50,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTextField(nameController, 'Nome', 'Ex: Hotel XYZ'),
            _buildTextField(addressController, 'Endereço', 'Ex: Rua A, 123'),
            _buildTextField(cityController, 'Cidade', 'Ex: São Paulo'),
            _buildTextField(stateController, 'Estado', 'Ex: SP'),
            _buildTextField(zipCodeController, 'CEP', 'Ex: 01234-567'),
            _buildTextField(
              numberRoomsController,
              'Número de Quartos',
              'Ex: 20',
              keyboardType: TextInputType.number,
            ),
            _buildTextField(
              phoneController,
              'Telefone (opcional)',
              'Ex: (11) 1234-5678',
            ),
            _buildTextField(
              descriptionController,
              'Descrição (opcional)',
              'Ex: Hotel com piscina',
            ),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String address = addressController.text;
                String city = cityController.text;
                String state = stateController.text;
                String zipCode = zipCodeController.text;
                int numberRooms = int.tryParse(numberRoomsController.text) ?? 0;
                String? phone =
                    phoneController.text.isNotEmpty
                        ? phoneController.text
                        : null;
                String? description =
                    descriptionController.text.isNotEmpty
                        ? descriptionController.text
                        : null;

                Hotel novoHotel = Hotel(
                  name: name,
                  address: address,
                  city: city,
                  state: state,
                  zipCode: zipCode,
                  numberRooms: numberRooms,
                  phone: phone,
                  description: description,
                );

                Navigator.pop(context, novoHotel);
              },
              child: Text(hotel == null ? 'Salvar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
