import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/screens/sales/models/invoice_line_entry.dart';

/// Cartão de linha de item na lista da nota.
/// [InvoiceLineEntry] - Objeto que representa uma linha de item na nota.
/// [onDelete] - Callback para deletar a linha de item.
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
        title: Semantics(
          label: '${product.name}, ${entry.quantity} vezes R\$ ${product.price.toStringAsFixed(2)}',
          child: Text(product.name),
        ),
        subtitle: ExcludeSemantics(
          child: Text('${entry.quantity}x R\$ ${product.price.toStringAsFixed(2)}'),
        ),
        trailing: IconButton(
          tooltip: 'Remover ${product.name}',
          icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
          onPressed: onDelete,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<InvoiceLineEntry>('entry', entry));
    properties.add(ObjectFlagProperty<VoidCallback>.has('onDelete', onDelete));
  }
}
