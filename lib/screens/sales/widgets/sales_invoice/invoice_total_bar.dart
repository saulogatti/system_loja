import 'package:flutter/material.dart';

/// Faixa de destaque com o valor total da nota.
class InvoiceTotalBar extends StatelessWidget {
  const InvoiceTotalBar({required this.total, super.key});

  final double total;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: scheme.primary.withAlpha(25), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Valor Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(
            'R\$ ${total.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: scheme.primary),
          ),
        ],
      ),
    );
  }
}
