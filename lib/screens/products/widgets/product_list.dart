import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/utils/utils_extensions.dart';
import 'package:system_loja/screens/widgets/card_list_item.dart';
import 'package:system_loja/screens/widgets/empty_widget.dart';

/// Widget da lista de produtos cadastrados
///
/// Exibe os produtos em formato de lista com cards ou mensagem quando vazio.
class ProductList extends StatelessWidget {

  const ProductList({
    required this.products,
    required this.onProductTap,
    super.key,
  });
  /// Espaçamento padrão entre título e lista
  static const double _defaultSpacing = 16;
  static const SliverGridDelegateWithMaxCrossAxisExtent _gridDelegate =
      SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 350,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        mainAxisExtent: 132,
      );

  final List<Product> products;
  final Function(Product) onProductTap;

  @override
  Widget build(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Produtos Cadastrados',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: _defaultSpacing),
        if (products.isEmpty)
          const EmptyWidget(
            message: 'Nenhum produto cadastrado',
            subMessage: 'Lista de produtos vazia.',
            icon: Icons.inventory_2_outlined,
            semanticLabel:
                'Lista de produtos vazia. Nenhum produto cadastrado.',
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Product>('products', products));
    properties.add(ObjectFlagProperty<Function(Product)>.has('onProductTap', onProductTap));
  }
}
