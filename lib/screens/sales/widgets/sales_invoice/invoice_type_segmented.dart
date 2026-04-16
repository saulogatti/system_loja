import 'package:flutter/material.dart';
import 'package:system_loja/core/models/invoice_type.dart';

/// Um único [SegmentedButton] para tipo de nota (entrada / saída).
/// [invoiceType] - Tipo de nota atual.
/// [onChanged] - Callback para quando o tipo de nota mudar.
class InvoiceTypeSegmented extends StatelessWidget {
  final InvoiceType invoiceType;
  final ValueChanged<InvoiceType> onChanged;

  const InvoiceTypeSegmented({
    required this.invoiceType,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<InvoiceType>(
      segments: const [
        ButtonSegment<InvoiceType>(
          value: InvoiceType.exit,
          label: Text('Saída (Venda)'),
          icon: Icon(Icons.arrow_upward),
        ),
        ButtonSegment<InvoiceType>(
          value: InvoiceType.entry,
          label: Text('Entrada (Compra)'),
          icon: Icon(Icons.arrow_downward),
        ),
      ],
      selected: {invoiceType},
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}
