import 'package:flutter/material.dart';
import 'package:system_loja/screens/sales/models/invoice_line_entry.dart';

/// Cartão de linha de item na lista da nota.
class InvoiceLineTile extends StatelessWidget {
  const InvoiceLineTile({required this.entry, required this.onDelete, super.key});

  final InvoiceLineEntry entry;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final product = entry.product;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(product.name),
        subtitle: Text('${entry.quantity}x R\$ ${product.price.toStringAsFixed(2)}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
