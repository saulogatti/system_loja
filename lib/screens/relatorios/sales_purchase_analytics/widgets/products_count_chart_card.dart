import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:system_loja/screens/relatorios/sales_purchase_analytics/bloc/sales_purchase_analytics_state.dart';
import 'package:system_loja/screens/widgets/empty_widget.dart';

class ProductsCountChartCard extends StatelessWidget {

  const ProductsCountChartCard({required this.points, super.key});
  final List<AnalyticsPoint> points;

  @override
  Widget build(BuildContext context) {
    final maxCount = points.fold<int>(0, (m, p) => p.productsCount > m ? p.productsCount : m);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.stacked_bar_chart, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Itens movimentados por data',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (points.isEmpty || maxCount <= 0)
              const EmptyWidget(message: 'Sem dados para exibir.', icon: Icons.bar_chart_outlined)
            else
              SizedBox(
                height: 170,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (final p in points)
                        _MiniBar(
                          label: p.label,
                          value: p.productsCount,
                          max: maxCount,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<AnalyticsPoint>('points', points));
  }
}

class _MiniBar extends StatelessWidget {

  const _MiniBar({
    required this.label,
    required this.value,
    required this.max,
    required this.color,
  });
  final String label;
  final int value;
  final int max;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final factor = max <= 0 ? 0.0 : (value / max).clamp(0.0, 1.0);
    final barHeight = 110 * factor;
    final labelText = label.length > 6 ? '${label.substring(0, 6)}…' : label;

    return Semantics(
      container: true,
      excludeSemantics: true,
      label: 'Data: $label. Produtos movimentados: $value',
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '$value',
              style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 6),
            Container(
              width: 18,
              height: barHeight < 2 ? 2 : barHeight,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 34,
              child: Text(
                labelText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('label', label));
    properties.add(IntProperty('value', value));
    properties.add(IntProperty('max', max));
    properties.add(ColorProperty('color', color));
  }
}
