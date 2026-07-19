import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChartLegend extends StatelessWidget {
  const ChartLegend({super.key});

  @override
  Widget build(BuildContext context) => const Row(
      children: [
        _LegendItem(color: Colors.green, label: 'Venda'),
        SizedBox(width: 16),
        _LegendItem(color: Colors.orange, label: 'Compra'),
      ],
    );
}

class _LegendItem extends StatelessWidget {

  const _LegendItem({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
    properties.add(StringProperty('label', label));
  }
}
