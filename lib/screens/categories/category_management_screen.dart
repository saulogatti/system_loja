import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/application/app_injection.dart';
import 'package:system_loja/core/interface/i_category_repository.dart';
import 'package:system_loja/core/models/category.dart';
import 'package:system_loja/screens/categories/cubit/category_cubit.dart';
import 'package:system_loja/screens/categories/cubit/category_state.dart';
import 'package:system_loja/screens/widgets/empty_widget.dart';

/// Tela de gerenciamento de categorias de produtos.
///
/// Permite visualizar, criar, editar e excluir categorias.
/// Acessível através das configurações da aplicação.
@RoutePage()
class CategoryManagementScreen extends StatefulWidget implements AutoRouteWrapper {
  const CategoryManagementScreen({super.key});

  @override
  State<CategoryManagementScreen> createState() => _CategoryManagementScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CategoryCubit>(
      create: (_) => CategoryCubit(repository: appInjection.get<ICategoryRepository>()),
      child: this,
    );
  }
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciar Categorias')),
      body: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            loaded: (_) {},
            created: (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Categoria criada com sucesso'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            updated: (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Categoria atualizada com sucesso'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            deleted: (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Categoria removida com sucesso'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            },
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: _buildCategoryList,
            created: _buildCategoryList,
            updated: _buildCategoryList,
            deleted: _buildCategoryList,
            error: _buildErrorWidget,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCategoryDialog,
        tooltip: 'Adicionar Categoria',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCategoryList(List<Category> categories) {
    if (categories.isEmpty) {
      return const EmptyWidget(
        message: 'Nenhuma categoria cadastrada',
        subMessage: 'Toque no botão + para adicionar',
        icon: Icons.category_outlined,
      );
    }

    return ListView.builder(
      itemCount: categories.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final category = categories[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(Icons.category, color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            title: Text(category.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: category.description != null ? Text(category.description!) : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
                  onPressed: () => _showCategoryDialog(category: category),
                  tooltip: 'Editar ${category.name}',
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                  onPressed: () => _confirmDeleteCategory(category),
                  tooltip: 'Excluir ${category.name}',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Theme.of(context).colorScheme.error),
          const SizedBox(height: 16),
          Text('Erro ao carregar categorias', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(message),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => context.read<CategoryCubit>().loadCategories(),
            icon: const Icon(Icons.refresh),
            label: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteCategory(Category category) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text(
          'Tem certeza que deseja excluir a categoria "${category.name}"?\n\n'
          'Esta ação não poderá ser desfeita e falhará se houver produtos associados.',
        ),
        actions: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => dialogContext.router.maybePop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Theme.of(context).colorScheme.onError,
                    ),
                    child: const Text('Excluir'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await context.read<CategoryCubit>().deleteCategory(category.id);
    }
  }

  Future<void> _showCategoryDialog({Category? category}) async {
    final nameController = TextEditingController(text: category?.name ?? '');
    final descriptionController = TextEditingController(text: category?.description ?? '');
    final formKey = GlobalKey<FormState>();
    final isEdit = category != null;

    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(isEdit ? 'Editar Categoria' : 'Nova Categoria'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nome *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
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
                  prefixIcon: Icon(Icons.description),
                ),
                minLines: 3,
                maxLines: null,
              ),
            ],
          ),
        ),
        actions: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (isEdit) {
                          await context.read<CategoryCubit>().updateCategory(
                            id: category.id,
                            name: nameController.text.trim(),
                            description: descriptionController.text.trim().isEmpty
                                ? null
                                : descriptionController.text.trim(),
                          );
                        } else {
                          await context.read<CategoryCubit>().createCategory(
                            name: nameController.text.trim(),
                            description: descriptionController.text.trim().isEmpty
                                ? null
                                : descriptionController.text.trim(),
                          );
                        }
                        if (dialogContext.mounted) {
                          Navigator.of(dialogContext).pop();
                        }
                      }
                    },
                    child: Text(isEdit ? 'Salvar' : 'Criar'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
