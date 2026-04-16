import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/screens/sales/cubit/sales_invoice_cubit.dart';
import 'package:system_loja/screens/sales/cubit/sales_invoice_state.dart';
import 'package:system_loja/screens/utils/validators.dart';

/// Campo do número da nota sincronizado com [SalesInvoiceCubit].
class InvoiceNumberField extends StatefulWidget {
  const InvoiceNumberField({super.key});

  @override
  State<InvoiceNumberField> createState() => _InvoiceNumberFieldState();
}

class _InvoiceNumberFieldState extends State<InvoiceNumberField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final initial = context.read<SalesInvoiceCubit>().state.form.invoiceNumber;
    _controller = TextEditingController(text: initial);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesInvoiceCubit, SalesInvoiceState>(
      listenWhen: (previous, current) =>
          previous.form.invoiceNumber != current.form.invoiceNumber ||
          previous.form.enableCodeGeneration !=
              current.form.enableCodeGeneration,
      listener: (context, state) {
        final n = state.form.invoiceNumber;
        if (_controller.text != n) {
          _controller.value = TextEditingValue(
            text: n,
            selection: TextSelection.collapsed(offset: n.length),
          );
        }
      },
      builder: (context, state) {
        final form = state.form;
        return TextFormField(
          readOnly: form.enableCodeGeneration,
          controller: _controller,
          onChanged: context.read<SalesInvoiceCubit>().updateInvoiceNumber,
          decoration: const InputDecoration(
            labelText: 'Número da Nota *',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.numbers),
          ),
          validator: (value) => validateRequired(value, 'Número da nota'),
        );
      },
    );
  }
}
