import 'package:flutter/material.dart';

void main() {
  runApp(const ListaComprasApp());
}

class ListaComprasApp extends StatelessWidget {
  const ListaComprasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ListaComprasScaffold(),
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ListaComprasScaffold extends StatelessWidget {
  const ListaComprasScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const FormularioComprasScaffold(),
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
        onPressed: () {
          FormularioComprasScaffold.show(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListaCompras extends StatelessWidget {
  const ListaCompras({super.key});

  @override
  Widget build(BuildContext context) {
    final produtos = [
      Produto("Café", 2),
      Produto("Leite", 1),
      Produto("Pão", 5),
      Produto("Queijo", 3),
      Produto("Presunto", 4),
      Produto("Manteiga", 2),
      Produto("Açúcar", 1),
      Produto("Arroz", 10),
      Produto("Feijão", 5),
      Produto("Macarrão", 3),
    ];

    return ListView.builder(
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        return ItemListaCompras(produto: produtos[index]);
      },
    );
  }
}

class ItemListaCompras extends StatelessWidget {
  final Produto produto;

  const ItemListaCompras({required this.produto, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: const Icon(Icons.shopping_cart),
        title: Text(produto.nome),
        subtitle: Text('Quantidade: ${produto.quantidade}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            // Ação do botão de deletar
          },
        ),
      ),
    );
  }
}

class Produto {
  final String nome;
  final int quantidade;

  Produto(this.nome, this.quantidade);
}


class FormularioComprasScaffold extends StatelessWidget {
  const FormularioComprasScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Produto'),
        backgroundColor: Colors.grey.shade50,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Nome do Produto',
                hintText: 'Ex: Café',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Quantidade',
                hintText: 'Ex: 2',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            onPressed: () {
             
            },
            child: const Text('Salvar'),
          ),
        ],
      )
    );
  }
  
  static void show(BuildContext context) {}
}




// import 'package:flutter/material.dart';

// void main() {
//   runApp(const ListaComprasApp());
// }

// class ListaComprasApp extends StatelessWidget {
//   const ListaComprasApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Lista de Compras',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       debugShowCheckedModeBanner: false,
//       home: const ListaComprasScaffold(),
//     );
//   }
// }

// class ListaComprasScaffold extends StatefulWidget {
//   const ListaComprasScaffold({super.key});

//   @override
//   State<ListaComprasScaffold> createState() => _ListaComprasScaffoldState();
// }

// class _ListaComprasScaffoldState extends State<ListaComprasScaffold> {
//   final List<Produto> _produtos = [
//     Produto("Café", 2),
//     Produto("Leite", 1),
//     Produto("Pão", 5),
//     Produto("Queijo", 3),
//     Produto("Presunto", 4),
//     Produto("Manteiga", 2),
//     Produto("Açúcar", 1),
//     Produto("Arroz", 10),
//     Produto("Feijão", 5),
//     Produto("Macarrão", 3),
//   ];

//   void _adicionarProduto(Produto produto) {
//     setState(() {
//       _produtos.add(produto);
//     });
//   }

//   void _removerProduto(int index) {
//     setState(() {
//       _produtos.removeAt(index);
//     });
//   }

//   Future<void> _abrirFormulario() async {
//     final Produto? novoProduto = await FormularioComprasScaffold.show(context);
//     if (novoProduto != null) {
//       _adicionarProduto(novoProduto);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lista de Compras'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: ListView.builder(
//         itemCount: _produtos.length,
//         itemBuilder: (context, index) {
//           return ItemListaCompras(
//             produto: _produtos[index],
//             onDelete: () => _removerProduto(index),
//           );
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações'),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _abrirFormulario,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class ItemListaCompras extends StatelessWidget {
//   final Produto produto;
//   final VoidCallback onDelete;

//   const ItemListaCompras({
//     required this.produto,
//     required this.onDelete,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//       child: ListTile(
//         leading: const Icon(Icons.shopping_cart),
//         title: Text(produto.nome),
//         subtitle: Text('Quantidade: ${produto.quantidade}'),
//         trailing: IconButton(
//           icon: const Icon(Icons.delete),
//           onPressed: onDelete,
//         ),
//       ),
//     );
//   }
// }

// class Produto {
//   final String nome;
//   final int quantidade;

//   Produto(this.nome, this.quantidade);
// }

// class FormularioComprasScaffold extends StatelessWidget {
//   const FormularioComprasScaffold({super.key});

//   static Future<Produto?> show(BuildContext context) {
//     return Navigator.of(context).push<Produto>(
//       MaterialPageRoute(
//         builder: (context) => const FormularioComprasScaffold(),
//         fullscreenDialog: true,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _formKey = GlobalKey<FormState>();
//     final TextEditingController _nomeController = TextEditingController();
//     final TextEditingController _quantidadeController = TextEditingController();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cadastro de Produto'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: _nomeController,
//                 decoration: const InputDecoration(
//                   labelText: 'Nome do Produto',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Informe o nome do produto';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _quantidadeController,
//                 decoration: const InputDecoration(
//                   labelText: 'Quantidade',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Informe a quantidade';
//                   }
//                   if (int.tryParse(value) == null) {
//                     return 'Número inválido';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState?.validate() == true) {
//                     final String nome = _nomeController.text;
//                     final int quantidade = int.parse(_quantidadeController.text);
//                     final novoProduto = Produto(nome, quantidade);
//                     Navigator.pop(context, novoProduto);
//                   }
//                 },
//                 child: const Text('Salvar'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }