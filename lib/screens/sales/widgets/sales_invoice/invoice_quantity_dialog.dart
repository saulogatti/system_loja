import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/core/models/invoice_type.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/screens/utils/input_formatters.dart';
import 'package:system_loja/screens/utils/validators.dart';

/// Diálogo para informar a quantidade de um produto; faz [State.dispose] do controller.
class InvoiceQuantityDialog extends StatefulWidget {
  const InvoiceQuantityDialog({required this.product, required this.invoiceType, super.key});
  final Product product;

  final InvoiceType invoiceType;

  @override
  State<InvoiceQuantityDialog> createState() => _InvoiceQuantityDialogState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
    properties.add(EnumProperty<InvoiceType>('invoiceType', invoiceType));
  }
}

class _InvoiceQuantityDialogState extends State<InvoiceQuantityDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return AlertDialog(
      title: Text('Quantidade de ${product.name}'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          keyboardType: TextInputType.number,
          inputFormatters: [QuantityInputFormatter()],
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) {
            if (_formKey.currentState!.validate()) {
              final quantity = int.parse(_controller.text.trim());
              context.router.maybePop(quantity);
            }
          },
          decoration: InputDecoration(
            labelText: 'Quantidade *',
            helperText: widget.invoiceType == InvoiceType.exit
                ? 'Estoque disponível: ${product.stockQuantity}'
                : 'Estoque atual: ${product.stockQuantity}',
            border: const OutlineInputBorder(),
          ),
          autofocus: true,
          validator: (value) {
            final error = validateQuantity(value);
            if (error != null) return error;

            final qtd = int.parse(value!.trim());
            if (widget.invoiceType == InvoiceType.exit && qtd > product.stockQuantity) {
              return 'Quantidade maior que o estoque disponível';
            }

            return null;
          },
        ),
      ),
      actions: [
        SizedBox(
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.router.maybePop(),
                  child: const Text('Cancelar'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final qtd = int.parse(_controller.text.trim());
                      context.router.maybePop(qtd);
                    }
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
