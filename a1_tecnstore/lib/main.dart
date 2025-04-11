import 'package:flutter/material.dart';
import 'screens/lista_objetos_screen.dart';

void main() {
  runApp(const ListaComprasApp());
}

class ListaComprasApp extends StatelessWidget {
  const ListaComprasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A1 Tecnstore',
      home: const ListaObjetosScreen(),
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
    );
  }
}
