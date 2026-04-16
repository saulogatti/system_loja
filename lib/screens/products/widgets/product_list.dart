import 'package:flutter/material.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/utils/utils_extensions.dart';
import 'package:system_loja/screens/widgets/card_list_item.dart';

/// Widget da lista de produtos cadastrados
///
/// Exibe os produtos em formato de lista com cards ou mensagem quando vazio.
class ProductList extends StatelessWidget {
  /// Espaçamento padrão entre título e lista
  static const double _defaultSpacing = 16.0;
  static const SliverGridDelegateWithMaxCrossAxisExtent _gridDelegate =
      SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 350,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        mainAxisExtent: 132,
      );

  final List<Product> products;
  final Function(Product) onProductTap;

  const ProductList({
    required this.products,
    required this.onProductTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Produtos Cadastrados',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: _defaultSpacing),
        if (products.isEmpty)
          Expanded(
            child: Center(
              child: Semantics(
                label:
                    'Nenhum produto cadastrado. Cadastre um novo produto para começar.',
                excludeSemantics: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 64,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha(128),
                    ),
                    const SizedBox(height: _defaultSpacing),
                    Text(
                      'Nenhum produto cadastrado',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text('Cadastre um novo produto para começar'),
                  ],
                ),
              ),
            ),
          )
        else
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              gridDelegate: _gridDelegate,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return CardListItem(
                  colorAvatar: Colors.green,
                  title: product.name,
                  subTitle:
                      'Código: ${product.code}\n${product.price.toFormattedPrice()} - Estoque: ${product.stockQuantity}',
                  margin: EdgeInsets.zero,
                  onTap: () => onProductTap(product),
                );
              },
            ),
          ),
      ],
    );
  }
}
