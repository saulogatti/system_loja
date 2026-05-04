import 'package:flutter/material.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/screens/widgets/empty_widget.dart';

/// Diálogo para escolher um produto na nota fiscal.
/// [products] - Lista de produtos disponíveis.
class SelectProductDialog extends StatelessWidget {
  final List<Product> products;

  const SelectProductDialog({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecionar Produto'),
      content: SizedBox(
        width: double.maxFinite,
        child: products.isEmpty
            ? const EmptyWidget(message: 'Nenhum produto disponível', icon: Icons.inventory_2_outlined)
            : ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text(
                      'R\$ ${product.price.toStringAsFixed(2)} - Estoque: ${product.stockQuantity}',
                    ),
                    trailing: Icon(Icons.add_circle_outline, color: Theme.of(context).colorScheme.primary),
                    onTap: () => Navigator.pop(context, product),
                  );
                },
              ),
      ),
      actions: [TextButton(onPressed: () => context.router.maybePop(), child: const Text('Cancelar'))],
    );
  }
}
