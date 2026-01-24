import 'package:flutter/material.dart';
import 'package:system_loja/core/utils/input_formatters.dart';
import 'package:system_loja/core/utils/validators.dart';
import 'package:system_loja/screens/products/widgets/product_category.dart';

/// Widget do formulário de cadastro de produto
///
/// Encapsula os campos de entrada e validações para criação de novos produtos.
class ProductForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController codigoController;
  final TextEditingController precoController;
  final TextEditingController estoqueController;
  final TextEditingController descricaoController;
  final VoidCallback onSubmit;
  final int? selectedCategoryId;
  final ValueChanged<int?> onCategoryChanged;

  const ProductForm({
    super.key,
    required this.formKey,
    required this.nomeController,
    required this.codigoController,
    required this.precoController,
    required this.estoqueController,
    required this.descricaoController,
    required this.onSubmit,
    this.selectedCategoryId,
    required this.onCategoryChanged,
  });

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Novo Produto',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: widget.nomeController,
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
            controller: widget.codigoController,
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
                  controller: widget.precoController,
                  decoration: const InputDecoration(
                    labelText: 'Preço *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                    helperText: 'Ex: 10,50',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [CurrencyInputFormatter()],
                  validator: validatePrice,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: widget.estoqueController,
                  decoration: const InputDecoration(
                    labelText: 'Estoque *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.inventory),
                    helperText: 'Ex: 10',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [QuantityInputFormatter()],
                  validator: validateStock,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ProductCategory(
            selectedCategoryId: widget.selectedCategoryId,
            onChanged: widget.onCategoryChanged,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.descricaoController,
            decoration: const InputDecoration(
              labelText: 'Descrição',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: widget.onSubmit,
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
                  controller: precoController,
                  decoration: const InputDecoration(
                    labelText: 'Preço (R\$) *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                    helperText: 'Ex: 10.50',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [PriceInputFormatter()],
                  validator: validatePrice,
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
                    helperText: 'Ex: 10',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [QuantityInputFormatter()],
                  validator: validateStock,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ProductCategory(controller: categoriaController, products: products),
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
