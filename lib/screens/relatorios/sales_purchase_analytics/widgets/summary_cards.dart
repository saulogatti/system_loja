import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/screens/relatorios/sales_purchase_analytics/bloc/sales_purchase_analytics_state.dart';

class SummaryCards extends StatelessWidget {
  const SummaryCards({required this.state, super.key});
  final SalesPurchaseAnalyticsLoaded state;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: _SummaryCard(
          title: 'Vendas',
          value: state.totalSales,
          color: Colors.green,
          icon: Icons.trending_up,
          suffix: r'R$',
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: _SummaryCard(
          title: 'Compras',
          value: state.totalPurchases,
          color: Colors.orange,
          icon: Icons.shopping_cart,
          suffix: r'R$',
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: _SummaryCard(
          title: 'Produtos',
          value: state.totalProducts.toDouble(),
          color: Theme.of(context).colorScheme.primary,
          icon: Icons.inventory,
          suffix: '',
        ),
      ),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<SalesPurchaseAnalyticsLoaded>('state', state));
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
    required this.suffix,
  });
  final String title;
  final double value;
  final Color color;
  final IconData icon;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    final textValue = suffix.isNotEmpty
        ? '$suffix ${value.toStringAsFixed(2)}'
        : value.toStringAsFixed(0);

    return Semantics(
      container: true,
      excludeSemantics: true,
      label: '$title: $textValue',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                textValue,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(DoubleProperty('value', value));
    properties.add(ColorProperty('color', color));
    properties.add(DiagnosticsProperty<IconData>('icon', icon));
    properties.add(StringProperty('suffix', suffix));
  }
}
