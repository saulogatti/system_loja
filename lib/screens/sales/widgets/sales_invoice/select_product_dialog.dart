import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/screens/widgets/empty_widget.dart';

/// Diálogo para escolher um produto na nota fiscal.
/// [products] - Lista de produtos disponíveis.
class SelectProductDialog extends StatelessWidget {
  const SelectProductDialog({required this.products, super.key});
  final List<Product> products;

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Selecionar Produto'),
    content: SizedBox(
      width: double.maxFinite,
      child: products.isEmpty
          ? const EmptyWidget(
              message: 'Nenhum produto disponível',
              icon: Icons.inventory_2_outlined,
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                final Color stockColor;
                final IconData stockIcon;

                if (product.stockQuantity == 0) {
                  stockColor = Theme.of(context).colorScheme.error;
                  stockIcon = Icons.remove_shopping_cart;
                } else if (product.stockQuantity <= 5) {
                  stockColor = Theme.of(context).colorScheme.secondary;
                  stockIcon = Icons.warning_amber;
                } else {
                  stockColor = Theme.of(context).colorScheme.primary;
                  stockIcon = Icons.add_circle_outline;
                }

                return Semantics(
                  button: true,
                  label:
                      'Adicionar produto: ${product.name}, preço: R\$ ${product.price.toStringAsFixed(2)}, estoque: ${product.stockQuantity}',
                  onTapHint: 'Adicionar produto à nota',
                  onTap: () => context.router.maybePop(product),
                  excludeSemantics: true,
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text(
                      'R\$ ${product.price.toStringAsFixed(2)} - Estoque: ${product.stockQuantity}',
                    ),
                    trailing: Icon(stockIcon, color: stockColor),
                    onTap: () => context.router.maybePop(product),
                  ),
                );
              },
            ),
    ),
    actions: [
      TextButton(onPressed: () => context.router.maybePop(), child: const Text('Cancelar')),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Product>('products', products));
  }
}
