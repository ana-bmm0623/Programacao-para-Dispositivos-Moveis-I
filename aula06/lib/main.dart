/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Lista de Compras"),
          backgroundColor: Colors.blue,
        ),
        body: ListaCompras(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (kDebugMode) {
              print("Clicou");
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    ),
  );
}

class ListaCompras extends StatelessWidget {
  const ListaCompras({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemListaCompras(Produto("Café", 35.50)),
        ItemListaCompras(Produto("Açúcar", 5.99)),
        ItemListaCompras(Produto("Leite", 17.59)),
      ],
    );
  }
}

class ItemListaCompras extends StatelessWidget {
 Produto produto;
  ItemListaCompras(this.produto, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
    child: ListTile(
    leading: Icon(Icons.coffee),
    title: Text(produto.title),
    subtitle: Text("R\$ ${produto.subtitle.toString()}"),
    ),
    );
  }
}

class Produto{
  String title;
  double subtitle;

  Produto(this.title, this.subtitle);
}*/

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Lista de Compras"),
          backgroundColor: Colors.blue,
        ),
        body: ListaCompras(),
      ),
    ),
  );
}

class ListaCompras extends StatefulWidget {
  @override
  _ListaComprasState createState() => _ListaComprasState();
}

class _ListaComprasState extends State<ListaCompras> {
  List<Item> itens = [];

  void _mostrarDialogoNovoItem() {
    String titulo = '';
    String subtitulo = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar Novo Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Título'),
                onChanged: (value) {
                  titulo = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Subtítulo'),
                onChanged: (value) {
                  subtitulo = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Adicionar'),
              onPressed: () {
                if (titulo.isNotEmpty && subtitulo.isNotEmpty) {
                  setState(() {
                    itens.add(Item(titulo: titulo, subtitulo: subtitulo));
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: itens.length,
        itemBuilder: (context, index) {
          return ItemListaCompras(item: itens[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoNovoItem,
        child: Icon(Icons.add),
      ),
    );
  }
}

class Item {
  final String titulo;
  final String subtitulo;

  Item({required this.titulo, required this.subtitulo});
}

class ItemListaCompras extends StatelessWidget {
  final Item item;

  ItemListaCompras({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.shopping_cart),
        title: Text(item.titulo),
        subtitle: Text("R\$ ${item.subtitulo} "),
      ),
    );
  }
}
