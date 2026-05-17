import 'package:flutter/material.dart';
import 'package:system_loja/screens/sales/models/invoice_line_entry.dart';

/// Cartão de linha de item na lista da nota.
/// [InvoiceLineEntry] - Objeto que representa uma linha de item na nota.
/// [onDelete] - Callback para deletar a linha de item.
class InvoiceLineTile extends StatelessWidget {
  final InvoiceLineEntry entry;

  final VoidCallback onDelete;
  const InvoiceLineTile({
    required this.entry,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final product = entry.product;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(product.name),
        subtitle: Text(
          '${entry.quantity}x R\$ ${product.price.toStringAsFixed(2)}',
        ),
        trailing: IconButton(
          tooltip: 'Remover ${product.name}',
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
