import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:system_loja/screens/relatorios/sales_purchase_analytics/bloc/sales_purchase_analytics_state.dart';

class ComparisonBarTile extends StatelessWidget {

  const ComparisonBarTile({required this.point, required this.maxValue, super.key});
  final AnalyticsPoint point;
  final double maxValue;

  @override
  Widget build(BuildContext context) {
    final safeMax = maxValue <= 0 ? 1.0 : maxValue;
    final salesFactor = point.salesValue / safeMax;
    final purchaseFactor = point.purchaseValue / safeMax;

    return Semantics(
      container: true,
      excludeSemantics: true,
      label:
          'Data: ${point.label}. Vendas: R\$ ${point.salesValue.toStringAsFixed(2)}. Compras: R\$ ${point.purchaseValue.toStringAsFixed(2)}. Produtos movimentados: ${point.productsCount}',
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      point.label,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.bar_chart, color: Theme.of(context).colorScheme.onSurfaceVariant),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 190,
                child: Row(
                  children: [
                    Expanded(
                      child: _VerticalValueBar(
                        title: 'Venda',
                        value: point.salesValue,
                        factor: salesFactor,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _VerticalValueBar(
                        title: 'Compra',
                        value: point.purchaseValue,
                        factor: purchaseFactor,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Produtos movimentados: ${point.productsCount}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
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
    properties.add(DiagnosticsProperty<AnalyticsPoint>('point', point));
    properties.add(DoubleProperty('maxValue', maxValue));
  }
}

class _VerticalValueBar extends StatelessWidget {

  const _VerticalValueBar({
    required this.title,
    required this.value,
    required this.factor,
    required this.color,
  });
  final String title;
  final double value;
  final double factor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final safeFactor = factor.clamp(0.0, 1.0);
    final barColor = color.withValues(alpha: 0.9);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
        const SizedBox(height: 6),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 26,
              height: math.max(6, 140.0 * safeFactor),
              decoration: BoxDecoration(color: barColor, borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'R\$ ${value.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.w700, color: color, fontSize: 12),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(DoubleProperty('value', value));
    properties.add(DoubleProperty('factor', factor));
    properties.add(ColorProperty('color', color));
  }
}
