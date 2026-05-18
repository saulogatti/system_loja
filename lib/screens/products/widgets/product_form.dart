import 'package:flutter/material.dart';
import 'package:system_loja/screens/utils/input_formatters.dart';
import 'package:system_loja/screens/utils/validators.dart';
import 'package:system_loja/screens/products/widgets/product_category.dart';
import 'package:system_loja/core/constants/app_constants.dart';

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
  final ValueChanged<bool> onSubmit;
  final int? selectedCategoryId;
  final ValueChanged<int?> onCategoryChanged;
  final bool isLoading;

  const ProductForm({
    required this.formKey,
    required this.nomeController,
    required this.codigoController,
    required this.precoController,
    required this.estoqueController,
    required this.descricaoController,
    required this.onSubmit,
    required this.onCategoryChanged,
    super.key,
    this.selectedCategoryId,
    this.isLoading = false,
  });

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  bool _generatedCode = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Novo Produto', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextFormField(
            enabled: !widget.isLoading,
            controller: widget.nomeController,
            textInputAction: TextInputAction.next,
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
            enabled: !widget.isLoading,
            readOnly: _generatedCode,
            controller: widget.codigoController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Código *',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.qr_code),
              suffixIcon: IconButton(
                tooltip: _generatedCode ? 'Desativar geração automática' : 'Gerar código automaticamente',
                onPressed: widget.isLoading ? null : () {
                  setState(() {
                    _generatedCode = !_generatedCode;
                    widget.codigoController.text = switch (_generatedCode) {
                      true => kStringGenerate,
                      _ => '',
                    };
                  });
                },
                icon: Icon(
                  Icons.generating_tokens_outlined,
                  color: _generatedCode ? Theme.of(context).colorScheme.primary : null,
                ),
              ),
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
                  enabled: !widget.isLoading,
                  controller: widget.precoController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Preço *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                    helperText: 'Ex: 10,50',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [PriceInputFormatter()],
                  validator: validatePrice,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  enabled: !widget.isLoading,
                  controller: widget.estoqueController,
                  textInputAction: TextInputAction.next,
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
            enabled: !widget.isLoading,
          ),
          const SizedBox(height: 16),
          TextFormField(
            enabled: !widget.isLoading,
            controller: widget.descricaoController,
            keyboardType: TextInputType.multiline,
            maxLength: 500,
            decoration: const InputDecoration(
              labelText: 'Descrição',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: widget.isLoading ? null : () => widget.onSubmit(_generatedCode),
            icon: widget.isLoading
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.add),
            label: Text(widget.isLoading ? 'Adicionando...' : 'Adicionar Produto'),
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
