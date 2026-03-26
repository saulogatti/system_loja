import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../bloc/sales_purchase_analytics_state.dart';

class ComparisonBarTile extends StatelessWidget {
  final AnalyticsPoint point;
  final double maxValue;

  const ComparisonBarTile({required this.point, required this.maxValue, super.key});

  @override
  Widget build(BuildContext context) {
    final safeMax = maxValue <= 0 ? 1.0 : maxValue;
    final salesFactor = point.salesValue / safeMax;
    final purchaseFactor = point.purchaseValue / safeMax;

    return Card(
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
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _VerticalValueBar extends StatelessWidget {
  final String title;
  final double value;
  final double factor;
  final Color color;

  const _VerticalValueBar({
    required this.title,
    required this.value,
    required this.factor,
    required this.color,
  });

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
              height: math.max(6.0, 140.0 * safeFactor),
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(10),
              ),
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
}

