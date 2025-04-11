import 'package:flutter/material.dart';
import '../models/objeto.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: const Icon(Icons.computer, color: Colors.blueAccent, size: 32),
        title: Text(
          objeto.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          "Ano: ${objeto.year} - Preço: R\$ ${objeto.price.toStringAsFixed(2)}\nCPU: ${objeto.cpuModel}\nHD: ${objeto.hardDiskSize}" +
              (objeto.color != null ? " - Cor: ${objeto.color}" : ""),
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
