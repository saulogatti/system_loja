import 'package:flutter/material.dart';
import 'package:system_loja/core/models/product.dart';

/// Diálogo para escolher um produto na nota fiscal.
class SelectProductDialog extends StatelessWidget {
  const SelectProductDialog({required this.products, super.key});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecionar Produto'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('R\$ ${product.price.toStringAsFixed(2)} - Estoque: ${product.stockQuantity}'),
              onTap: () => Navigator.pop(context, product),
            );
          },
        ),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar'))],
    );
  }
}
