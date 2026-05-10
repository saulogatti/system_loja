import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/application/app_injection.dart';
import 'package:system_loja/core/interface/i_product_repository.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/screens/products/cubit/product_cubit.dart';
import 'package:system_loja/screens/products/cubit/product_state.dart';
import 'package:system_loja/screens/products/product_list_screen.dart';
import 'package:system_loja/screens/products/widgets/product_category.dart';
import 'package:system_loja/screens/utils/extension_date_time.dart';

/// Tela de detalhes do produto com opções de edição e exclusão
///
/// Permite visualizar informações completas do produto e realizar operações como:
/// - Editar dados do produto
/// - Deletar produto
@RoutePage()
class ProductDetailScreen extends StatefulWidget implements AutoRouteWrapper {
  final Product product;
  final List<Product> productList;

  const ProductDetailScreen({required this.product, super.key, this.productList = const []});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ProductCubit>(
      create: (_) => ProductCubit(appInjection.get<IProductRepository>()),
      child: this,
    );
  }
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late final TextEditingController _nomeController;
  late final TextEditingController _codigoController;
  late final TextEditingController _precoController;
  late final TextEditingController _estoqueController;
  late final TextEditingController _descricaoController;
  int? _selectedCategoryId;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        switch (state) {
          case ProductStateUpdateSuccess():
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Produto atualizado com sucesso!'), backgroundColor: Colors.green),
            );
            ProductListScreen.requestReload();
            context.router.maybePop(true);
          case ProductStateDeleteSuccess():
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Produto deletado com sucesso!'), backgroundColor: Colors.green),
            );
            ProductListScreen.requestReload();
            context.router.maybePop(true);
          case ProductStateError(:final message):
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
          default:
            break;
        }
      },
      builder: (context, state) {
        final isLoading = state is ProductStateLoading;
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.delete),
                onPressed: isLoading ? null : _confirmarExclusao,
                tooltip: 'Deletar ${widget.product.name}',
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Ícone e nome do produto
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.inventory_2, size: 50, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Informações principais do produto
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Informações do Produto',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _nomeController,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'Nome *',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.inventory_2),
                            ),
                            enabled: !isLoading,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Nome é obrigatório';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _codigoController,
                            decoration: const InputDecoration(
                              labelText: 'Código *',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.qr_code),
                            ),
                            enabled: false,
                            readOnly: true,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _precoController,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    labelText: 'Preço (R\$) *',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.attach_money),
                                  ),
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  enabled: !isLoading,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Preço é obrigatório';
                                    }
                                    final preco = double.tryParse(value.trim().replaceAll(',', '.'));
                                    if (preco == null || preco < 0) {
                                      return 'Preço inválido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  controller: _estoqueController,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    labelText: 'Estoque *',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.inventory),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  enabled: !isLoading,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Estoque é obrigatório';
                                    }
                                    final estoque = int.tryParse(value.trim());
                                    if (estoque == null || estoque < 0) {
                                      return 'Estoque inválido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ProductCategory(
                            selectedCategoryId: _selectedCategoryId,
                            enabled: !isLoading,
                            onChanged: (categoryId) {
                              setState(() {
                                _selectedCategoryId = categoryId;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _descricaoController,
                            decoration: const InputDecoration(
                              labelText: 'Descrição',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.description),
                            ),
                            enabled: !isLoading,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Card com informações do sistema
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Informações do Sistema',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow('ID', widget.product.code.toString(), Icons.numbers),
                          const Divider(),
                          _buildInfoRow(
                            'Data de Cadastro',
                            widget.product.registrationDate.toFormattedDate(),
                            Icons.calendar_today,
                          ),
                          const Divider(),
                          _buildInfoRow(
                            'Data de Atualização',
                            widget.product.lastUpdatedDate.toFormattedDate(),
                            Icons.calendar_today,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: isLoading ? null : () => context.router.maybePop(false),
                          child: const Text('Voltar'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _salvarAlteracoes,
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Text('Salvar Alterações'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _codigoController.dispose();
    _precoController.dispose();
    _estoqueController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.product.name);
    _codigoController = TextEditingController(text: widget.product.code);
    _precoController = TextEditingController(text: widget.product.price.toStringAsFixed(2));
    _estoqueController = TextEditingController(text: widget.product.stockQuantity.toString());
    _descricaoController = TextEditingController(text: widget.product.description);
    _selectedCategoryId = widget.product.categoryId;
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmarExclusao() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: TextButton(onPressed: () => context.router.maybePop(), child: const Text('Cancelar')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Fecha o diálogo
              context.read<ProductCubit>().deleteProduct(widget.product.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Deletar'),
          ),
        ],
      ),
    );
  }

  void _salvarAlteracoes() {
    if (_formKey.currentState!.validate()) {
      final preco = double.parse(_precoController.text.trim().replaceAll(',', '.'));
      final estoque = int.parse(_estoqueController.text.trim());

      final updatedProduct = widget.product.copyWith(
        name: _nomeController.text.trim(),

        price: preco,
        stockQuantity: estoque,
        description: _descricaoController.text.trim(),
        categoryId: _selectedCategoryId,

        lastUpdatedDate: DateTime.now(),
      );

      context.read<ProductCubit>().updateProduct(updatedProduct);
    }
  }
}
