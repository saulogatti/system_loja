import 'package:flutter/material.dart';

/// Widget do formulário de cadastro de produto
///
/// Encapsula os campos de entrada e validações para criação de novos produtos.
class ProductForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController codigoController;
  final TextEditingController precoController;
  final TextEditingController estoqueController;
  final TextEditingController descricaoController;
  final TextEditingController categoriaController;
  final VoidCallback onSubmit;

  const ProductForm({
    super.key,
    required this.formKey,
    required this.nomeController,
    required this.codigoController,
    required this.precoController,
    required this.estoqueController,
    required this.descricaoController,
    required this.categoriaController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Novo Produto',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome do Produto *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.inventory_2),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Nome é obrigatório';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: codigoController,
            decoration: const InputDecoration(
              labelText: 'Código *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.qr_code),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Código é obrigatório';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: precoController,
                  decoration: const InputDecoration(
                    labelText: 'Preço (R\$) *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Preço é obrigatório';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: estoqueController,
                  decoration: const InputDecoration(
                    labelText: 'Estoque *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.inventory),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Estoque é obrigatório';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: categoriaController,
            decoration: const InputDecoration(
              labelText: 'Categoria',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.category),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: descricaoController,
            decoration: const InputDecoration(
              labelText: 'Descrição',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onSubmit,
            icon: const Icon(Icons.add),
            label: const Text('Adicionar Produto'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
