import 'package:flutter/material.dart';
import '../components/item_lista_objetos.dart';
import '../models/objeto.dart';
import '../services/api_service.dart';
import 'formulario_objeto_screen.dart';

class ListaObjetosScreen extends StatefulWidget {
  const ListaObjetosScreen({super.key});

  @override
  _ListaObjetosScreenState createState() => _ListaObjetosScreenState();
}

class _ListaObjetosScreenState extends State<ListaObjetosScreen> {
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao carregar objetos: $e")));
    }
  }

  // Método para adicionar um novo objeto
  void _adicionarObjeto() async {
    final novoObjetoRecebido = await Navigator.push<Objeto>(
      context,
      MaterialPageRoute(builder: (context) => const FormularioObjetoScreen()),
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
        print("Erro ao criar objeto: $e");
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
        builder: (context) => FormularioObjetoScreen(objeto: objetoAtual),
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
        print("Erro ao atualizar objeto: $e");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erro ao atualizar objeto: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  itemCount: _objetos.length,
                  itemBuilder: (context, index) {
                    return ItemListaObjetos(
                      objeto: _objetos[index],
                      onDelete: () async {
                        // Exibe o diálogo de confirmação
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
                            await apiService.deleteObjeto(_objetos[index].id!);
                            setState(() {
                              _objetos.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Objeto excluído com sucesso!"),
                              ),
                            );
                          } catch (e) {
                            print("Erro ao excluir objeto: $e");
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
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarObjeto,
        child: const Icon(Icons.add),
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
    );
  }
}
