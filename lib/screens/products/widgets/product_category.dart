import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/aplication/app_injection.dart';
import 'package:system_loja/core/interface/i_category_repository.dart';
import 'package:system_loja/core/models/category.dart';
import 'package:system_loja/screens/categories/cubit/category_cubit.dart';
import 'package:system_loja/screens/categories/cubit/category_state.dart';

/// Widget de seleção e criação de categorias de produto.
///
/// Permite selecionar uma categoria existente de um dropdown ou criar uma nova
/// através de um diálogo. As categorias são carregadas do banco de dados
/// através do CategoryCubit.
class ProductCategory extends StatefulWidget {
  /// ID da categoria selecionada
  final int? selectedCategoryId;

  /// Callback chamado quando a categoria é alterada
  final ValueChanged<int?>? onChanged;

  /// Indica se o campo é obrigatório
  final bool required;

  /// Indica se o campo está habilitado
  final bool enabled;

  const ProductCategory({
    super.key,
    this.selectedCategoryId,
    this.onChanged,
    this.required = false,
    this.enabled = true,
  });

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  int? _selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryCubit(repository: appInjection.get<ICategoryRepository>()),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          return state.when(
            initial: () => const CircularProgressIndicator(),
            loading: () => const CircularProgressIndicator(),
            loaded: (categories) => _buildDropdown(context, categories),
            created: (categories) => _buildDropdown(context, categories),
            updated: (categories) => _buildDropdown(context, categories),
            deleted: (categories) => _buildDropdown(context, categories),
            error: (message) => _buildErrorWidget(context, message),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedCategoryId = widget.selectedCategoryId;
  }

  Widget _buildDropdown(BuildContext context, List<Category> categories) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<int>(
            initialValue: _selectedCategoryId,
            hint: const Text('Selecione uma categoria'),
            decoration: InputDecoration(
              labelText: widget.required ? 'Categoria *' : 'Categoria',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.category),
            ),
            items: categories.map((category) {
              return DropdownMenuItem<int>(value: category.id, child: Text(category.name));
            }).toList(),
            onChanged: widget.enabled
                ? (value) {
                    _selectedCategoryId = value;

                    widget.onChanged?.call(value);
                  }
                : null,
            validator: widget.required
                ? (value) {
                    if (value == null) {
                      return 'Selecione uma categoria';
                    }
                    return null;
                  }
                : null,
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: widget.enabled ? () => _showCreateCategoryDialog(context) : null,
          icon: const Icon(Icons.add),
          tooltip: 'Adicionar nova categoria',
        ),
      ],
    );
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Erro ao carregar categorias: $message',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => context.read<CategoryCubit>().loadCategories(),
          icon: const Icon(Icons.refresh),
          label: const Text('Tentar novamente'),
        ),
      ],
    );
  }

  Future<void> _showCreateCategoryDialog(BuildContext parentContext) async {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nova Categoria'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nome *',
                  border: OutlineInputBorder(),
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
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                maxLength: 500,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => context.router.pop(), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                // Use parent context to access the cubit
                final cubit = parentContext.read<CategoryCubit>();
                await cubit.createCategory(
                  name: nameController.text.trim(),
                  description: descriptionController.text.trim().isEmpty
                      ? null
                      : descriptionController.text.trim(),
                );

                // Check if successful before showing message
                if (context.mounted) {
                  final currentState = cubit.state;
                  context.router.pop();

                  if (currentState is CategoryCreated) {
                    ScaffoldMessenger.of(
                      parentContext,
                    ).showSnackBar(const SnackBar(content: Text('Categoria criada com sucesso')));
                  }
                }
              }
            },
            child: const Text('Criar'),
          ),
        ],
      ),
    );
  }
}
