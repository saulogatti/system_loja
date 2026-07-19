import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/core/models/invoice_type.dart';

/// Um único [SegmentedButton] para tipo de nota (entrada / saída).
/// [invoiceType] - Tipo de nota atual.
/// [onChanged] - Callback para quando o tipo de nota mudar.
class InvoiceTypeSegmented extends StatelessWidget {
  const InvoiceTypeSegmented({required this.invoiceType, required this.onChanged, super.key});
  final InvoiceType invoiceType;
  final ValueChanged<InvoiceType> onChanged;

  @override
  Widget build(BuildContext context) => SegmentedButton<InvoiceType>(
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<InvoiceType>('invoiceType', invoiceType));
    properties.add(ObjectFlagProperty<ValueChanged<InvoiceType>>.has('onChanged', onChanged));
  }
}
