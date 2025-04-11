import 'package:flutter/material.dart';
import '../models/objeto.dart';

class FormularioObjetoScreen extends StatelessWidget {
  final Objeto? objeto;
  const FormularioObjetoScreen({super.key, this.objeto});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(
      text: objeto?.name ?? '',
    );
    final TextEditingController yearController = TextEditingController(
      text: objeto != null ? objeto!.year.toString() : '',
    );
    final TextEditingController priceController = TextEditingController(
      text: objeto != null ? objeto!.price.toString() : '',
    );
    final TextEditingController cpuModelController = TextEditingController(
      text: objeto?.cpuModel ?? '',
    );
    final TextEditingController hardDiskSizeController = TextEditingController(
      text: objeto?.hardDiskSize ?? '',
    );
    final TextEditingController colorController = TextEditingController(
      text: objeto?.color ?? '',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          objeto == null ? 'Cadastro de Objeto' : 'Atualização de Objeto',
        ),
        backgroundColor: Colors.grey.shade50,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(nameController, 'Nome', 'Ex: Apple MacBook Pro 16'),
            _buildTextField(
              yearController,
              'Ano',
              'Ex: 2019',
              keyboardType: TextInputType.number,
            ),
            _buildTextField(
              priceController,
              'Preço',
              'Ex: 1849.99',
              keyboardType: TextInputType.number,
            ),
            _buildTextField(
              cpuModelController,
              'CPU model',
              'Ex: Intel Core i9',
            ),
            _buildTextField(
              hardDiskSizeController,
              'Hard disk size',
              'Ex: 1 TB',
            ),
            _buildTextField(colorController, 'Cor (opcional)', 'Ex: silver'),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                int year = int.tryParse(yearController.text) ?? 0;
                double price = double.tryParse(priceController.text) ?? 0.0;
                String cpuModel = cpuModelController.text;
                String hardDiskSize = hardDiskSizeController.text;
                String? color =
                    colorController.text.isNotEmpty
                        ? colorController.text
                        : null;

                Objeto novoObjeto = Objeto(
                  name: name,
                  year: year,
                  price: price,
                  cpuModel: cpuModel,
                  hardDiskSize: hardDiskSize,
                  color: color,
                );

                Navigator.pop(context, novoObjeto);
              },
              child: Text(objeto == null ? 'Salvar' : 'Atualizar'),
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
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
