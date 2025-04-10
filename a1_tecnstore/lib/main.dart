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
      home: const ListaObjetosScaffold(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 2),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Tela principal que exibe a lista de objetos e permite cadastrar/atualizar
class ListaObjetosScaffold extends StatefulWidget {
  const ListaObjetosScaffold({super.key});

  @override
  _ListaObjetosScaffoldState createState() => _ListaObjetosScaffoldState();
}

class _ListaObjetosScaffoldState extends State<ListaObjetosScaffold> {
  final RestfulApiService apiService = RestfulApiService();
  List<Objeto> _objetos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarObjetos();
  }

  void _carregarObjetos() async {
    try {
      final objetos = await apiService.getObjetos();
      setState(() {
        _objetos = objetos;
        _isLoading = false;
      });
    } catch (e) {
      print("Erro ao carregar objetos: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Método para adicionar um novo objeto
  void _adicionarObjeto() async {
    final novoObjetoRecebido = await Navigator.push<Objeto>(
      context,
      MaterialPageRoute(builder: (context) => const FormularioObjetoScaffold()),
    );
    if (novoObjetoRecebido != null) {
      try {
        final novoObjeto = await apiService.createObjeto(novoObjetoRecebido);
        setState(() {
          _objetos.add(novoObjeto);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Objeto cadastrado com sucesso!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erro ao criar objeto: $e")));
      }
    }
  }

  // Método para atualizar um objeto existente
  void _atualizarObjeto(int index) async {
    final objetoAtual = _objetos[index];
    final objetoAtualizado = await Navigator.push<Objeto>(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioObjetoScaffold(objeto: objetoAtual),
      ),
    );
    if (objetoAtualizado != null) {
      try {
        final resultado = await apiService.updateObjeto(
          objetoAtual.id!,
          objetoAtualizado,
        );
        setState(() {
          _objetos[index] = resultado;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Objeto atualizado com sucesso!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erro ao atualizar objeto: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Objetos'),
          backgroundColor: Colors.blueAccent,
        ),
        body:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                  onRefresh: () async {
                    _carregarObjetos();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    itemCount: _objetos.length,
                    itemBuilder: (context, index) {
                      return ItemListaObjetos(
                        objeto: _objetos[index],
                        onDelete: () async {
                          bool? confirm = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirmar Exclusão"),
                                content: const Text(
                                  "Tem certeza que deseja excluir este objeto?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(false),
                                    child: const Text("Cancelar"),
                                  ),
                                  TextButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(true),
                                    child: const Text(
                                      "Excluir",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                          if (confirm == true) {
                            try {
                              await apiService.deleteObjeto(
                                _objetos[index].id!,
                              );
                              setState(() {
                                _objetos.removeAt(index);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Objeto excluído com sucesso!"),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Erro ao excluir objeto: $e"),
                                ),
                              );
                            }
                          }
                        },
                        onUpdate: () => _atualizarObjeto(index),
                      );
                    },
                  ),
                ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configurações',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _adicionarObjeto,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

// Widget que exibe cada objeto em um Card com botões de atualizar e excluir
class ItemListaObjetos extends StatelessWidget {
  final Objeto objeto;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const ItemListaObjetos({
    required this.objeto,
    required this.onDelete,
    required this.onUpdate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          leading: const Icon(
            Icons.computer,
            color: Colors.blueAccent,
            size: 32,
          ),
          title: Text(
            objeto.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ano: ${objeto.year}  •  Preço: R\$ ${objeto.price.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  "CPU: ${objeto.cpuModel}  •  HD: ${objeto.hardDiskSize}",
                  style: const TextStyle(fontSize: 14),
                ),
                if (objeto.color != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "Cor: ${objeto.color}",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
              ],
            ),
          ),
          trailing: Column(
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
      ),
    );
  }
}

// Modelo representando um objeto conforme a API RESTful
class Objeto {
  final String? id;
  final String name;
  final int year;
  final double price;
  final String cpuModel;
  final String hardDiskSize;
  final String? color;

  Objeto({
    this.id,
    required this.name,
    required this.year,
    required this.price,
    required this.cpuModel,
    required this.hardDiskSize,
    this.color,
  });

  factory Objeto.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return Objeto(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      year:
          data['year'] != null ? int.tryParse(data['year'].toString()) ?? 0 : 0,
      price: data['price'] != null ? (data['price'] as num).toDouble() : 0.0,
      cpuModel: data['CPU model'] ?? '',
      hardDiskSize: data['Hard disk size'] ?? '',
      color: data['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'data': {
        'year': year,
        'price': price,
        'CPU model': cpuModel,
        'Hard disk size': hardDiskSize,
        if (color != null) 'color': color,
      },
    };
  }
}

// Serviço para consumir a API RESTful
class RestfulApiService {
  static const String baseUrl = "https://api.restful-api.dev/objects";

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

// Tela de formulário para cadastro ou atualização de um objeto
class FormularioObjetoScaffold extends StatefulWidget {
  final Objeto? objeto;
  const FormularioObjetoScaffold({super.key, this.objeto});

  @override
  State<FormularioObjetoScaffold> createState() =>
      _FormularioObjetoScaffoldState();
}

class _FormularioObjetoScaffoldState extends State<FormularioObjetoScaffold> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController yearController;
  late TextEditingController priceController;
  late TextEditingController cpuModelController;
  late TextEditingController hardDiskSizeController;
  late TextEditingController colorController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.objeto?.name ?? '');
    yearController = TextEditingController(
      text: widget.objeto != null ? widget.objeto!.year.toString() : '',
    );
    priceController = TextEditingController(
      text: widget.objeto != null ? widget.objeto!.price.toString() : '',
    );
    cpuModelController = TextEditingController(
      text: widget.objeto?.cpuModel ?? '',
    );
    hardDiskSizeController = TextEditingController(
      text: widget.objeto?.hardDiskSize ?? '',
    );
    colorController = TextEditingController(text: widget.objeto?.color ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    yearController.dispose();
    priceController.dispose();
    cpuModelController.dispose();
    hardDiskSizeController.dispose();
    colorController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final novoObjeto = Objeto(
        name: nameController.text,
        year: int.tryParse(yearController.text) ?? 0,
        price: double.tryParse(priceController.text) ?? 0.0,
        cpuModel: cpuModelController.text,
        hardDiskSize: hardDiskSizeController.text,
        color: colorController.text.isNotEmpty ? colorController.text : null,
      );
      Navigator.pop(context, novoObjeto);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.objeto == null
              ? 'Cadastro de Objeto'
              : 'Atualização de Objeto',
        ),
        backgroundColor: Colors.blueAccent,
      ),
      // Aqui definimos resizeToAvoidBottomInset como true (valor padrão)
      // e ajustamos o padding inferior do SingleChildScrollView com
      // MediaQuery para compensar o teclado.
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  nameController,
                  'Nome',
                  'Ex: Apple MacBook Pro 16',
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Digite o nome do objeto';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  yearController,
                  'Ano',
                  'Ex: 2019',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Digite o ano';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  priceController,
                  'Preço',
                  'Ex: 1849.99',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Digite o preço';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  cpuModelController,
                  'CPU model',
                  'Ex: Intel Core i9',
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Digite o modelo da CPU';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  hardDiskSizeController,
                  'Hard disk size',
                  'Ex: 1 TB',
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Digite o tamanho do HD';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  colorController,
                  'Cor (opcional)',
                  'Ex: Silver',
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: Text(widget.objeto == null ? 'Salvar' : 'Atualizar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}
