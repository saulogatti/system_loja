import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/utils/utils_extensions.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';
import 'package:system_loja/screens/utils/extension_date_time.dart';

/// Exibe um bottom sheet com visão geral dos dados do produto.
///
/// Mostra as informações principais do produto e oferece ação de navegação
/// para a tela de detalhes completa.
class ProductOverviewBottomSheet extends StatelessWidget {
  /// Produto cujas informações serão exibidas.
  final Product product;

  /// Lista de produtos usada para passar ao contexto de detalhes.
  final List<Product> productList;

  /// Cria uma instância de [ProductOverviewBottomSheet].
  const ProductOverviewBottomSheet({
    required this.product, super.key,
    this.productList = const [],
  });

  /// Exibe o bottom sheet de visão geral do produto.
  static Future<void> show(
    BuildContext context,
    Product product,
    List<Product> productList,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => ProductOverviewBottomSheet(
        product: product,
        productList: productList,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.green,
                  child: const Icon(
                    Icons.inventory_2,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Código: ${product.code}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            _InfoRow(
              icon: Icons.attach_money,
              label: 'Preço',
              value: product.price.toFormattedPrice(),
            ),
            _InfoRow(
              icon: Icons.inventory,
              label: 'Estoque',
              value: '${product.stockQuantity} unidade(s)',
            ),
            if (product.description.isNotEmpty)
              _InfoRow(
                icon: Icons.description_outlined,
                label: 'Descrição',
                value: product.description,
              ),
            _InfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'Cadastrado em',
              value: product.registrationDate.toFormattedDate(),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                context.router.root.push(
                  ProductDetailRoute(
                    product: product,
                    productList: productList,
                  ),
                );
              },
              icon: const Icon(Icons.open_in_new),
              label: const Text('Ver Detalhes'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Linha de informação com ícone, rótulo e valor.
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(value, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
