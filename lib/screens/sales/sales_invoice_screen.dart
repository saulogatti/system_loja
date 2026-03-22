import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart';
import 'package:system_loja/screens/sales/cubit/sales_invoice_cubit.dart';
import 'package:system_loja/screens/sales/cubit/sales_invoice_state.dart';
import 'package:system_loja/screens/sales/models/person_selection.dart';
import 'package:system_loja/screens/sales/widgets/sales_invoice/invoice_line_tile.dart';
import 'package:system_loja/screens/sales/widgets/sales_invoice/invoice_number_field.dart';
import 'package:system_loja/screens/sales/widgets/sales_invoice/invoice_quantity_dialog.dart';
import 'package:system_loja/screens/sales/widgets/sales_invoice/invoice_total_bar.dart';
import 'package:system_loja/screens/sales/widgets/sales_invoice/invoice_type_segmented.dart';
import 'package:system_loja/screens/sales/widgets/sales_invoice/select_product_dialog.dart';

/// Evita SnackBar duplicado ao reemitir o mesmo [SalesInvoiceFeedback].
bool _shouldListenForFeedbackSnackBar(SalesInvoiceState previous, SalesInvoiceState current) {
  if (current is! SalesInvoiceFeedback) return false;
  if (previous is! SalesInvoiceFeedback) return true;
  return previous.message != current.message;
}

@RoutePage()
class SalesInvoiceScreen extends StatelessWidget {
  final List<PaymentMethodType> paymentMethods;
  final Map<int, Customer> customers;
  final Map<int, Company> companies;
  final SalesCubit salesCubit;
  final List<Product> products;

  const SalesInvoiceScreen({
    required this.paymentMethods,
    required this.customers,
    required this.companies,
    required this.salesCubit,
    required this.products,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SalesInvoiceCubit(salesCubit: salesCubit, paymentMethods: paymentMethods),
      child: _SalesInvoiceBody(
        paymentMethods: paymentMethods,
        customers: customers,
        companies: companies,
        products: products,
      ),
    );
  }
}

class _SalesInvoiceBody extends StatefulWidget {
  final List<PaymentMethodType> paymentMethods;

  final Map<int, Customer> customers;
  final Map<int, Company> companies;
  final List<Product> products;
  const _SalesInvoiceBody({
    required this.paymentMethods,
    required this.customers,
    required this.companies,
    required this.products,
  });

  @override
  State<_SalesInvoiceBody> createState() => _SalesInvoiceBodyState();
}

class _SalesInvoiceBodyState extends State<_SalesInvoiceBody> {
  final _formKey = GlobalKey<FormState>();

  late final List<PersonSelection> _personOptions = [
    ...widget.customers.values.map(CustomerSelection.new),
    ...widget.companies.values.map(CompanySelection.new),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<SalesInvoiceCubit, SalesInvoiceState>(
      listenWhen: _shouldListenForFeedbackSnackBar,
      listener: (context, state) {
        if (state case SalesInvoiceFeedback(:final message)) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
          context.read<SalesInvoiceCubit>().consumeFeedback();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Nota Fiscal'),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          leading: const AutoLeadingButton(),
        ),
        body: Form(
          key: _formKey,
          child: BlocBuilder<SalesInvoiceCubit, SalesInvoiceState>(
            builder: (context, state) {
              final form = state.form;
              final orderedLines = form.buildOrderedLines();
              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: InvoiceNumberField()),
                  SliverToBoxAdapter(
                    child: IconButton(
                      onPressed: () => context.read<SalesInvoiceCubit>().toggleAutoInvoiceNumber(),
                      icon: const Icon(Icons.generating_tokens_outlined),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: InvoiceTypeSegmented(
                      invoiceType: form.invoiceType,
                      onChanged: context.read<SalesInvoiceCubit>().setInvoiceType,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverToBoxAdapter(
                    child: DropdownButtonFormField<PersonSelection>(
                      // value controlado pelo Bloc; initialValue não reflete mudanças.
                      // ignore: deprecated_member_use
                      value: form.person,
                      decoration: InputDecoration(
                        labelText: 'Cliente ou Empresa *',
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(form.person?.icon ?? Icons.person_search),
                      ),
                      items: _personOptions.map((person) {
                        return DropdownMenuItem(
                          value: person,
                          child: Row(
                            children: [
                              Icon(person.icon, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${person.displayName} (${person.document})',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) => context.read<SalesInvoiceCubit>().setPerson(value),
                      validator: (value) {
                        if (value == null) {
                          return 'Selecione um cliente ou empresa';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverToBoxAdapter(
                    child: DropdownButtonFormField<PaymentMethodType>(
                      // ignore: deprecated_member_use
                      value: form.paymentMethod,
                      decoration: const InputDecoration(
                        labelText: 'Forma de Pagamento *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.payment),
                        helperText: 'Ex: Dinheiro, Cartão, Pix',
                      ),
                      items: widget.paymentMethods.map((method) {
                        return DropdownMenuItem(value: method, child: Text(method.name));
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        context.read<SalesInvoiceCubit>().setPaymentMethod(value);
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Selecione uma forma de pagamento';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Itens', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ElevatedButton.icon(
                          onPressed: _onAddItem,
                          icon: const Icon(Icons.add),
                          label: const Text('Adicionar Item'),
                        ),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  if (orderedLines.isEmpty)
                    const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: Text('Nenhum item adicionado', style: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    )
                  else
                    SliverList.builder(
                      itemCount: orderedLines.length,
                      itemBuilder: (context, index) {
                        final line = orderedLines[index];
                        return InvoiceLineTile(
                          entry: line,
                          onDelete: () => context.read<SalesInvoiceCubit>().removeLine(line.product.id),
                        );
                      },
                    ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  SliverToBoxAdapter(child: InvoiceTotalBar(total: form.computeTotal())),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  SliverToBoxAdapter(
                    child: ElevatedButton(
                      onPressed: _onSave,
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                      child: const Text('Salvar Nota Fiscal', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onAddItem() async {
    final product = await showDialog<Product>(
      context: context,
      builder: (context) => SelectProductDialog(products: widget.products),
    );

    if (product == null || !mounted) return;
    final invoiceCubit = context.read<SalesInvoiceCubit>();
    final quantity = await showDialog<int>(
      context: context,
      builder: (context) =>
          InvoiceQuantityDialog(product: product, invoiceType: invoiceCubit.state.form.invoiceType),
    );

    if (quantity == null || !mounted) return;

    invoiceCubit.addOrMergeLine(product, quantity);
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<SalesInvoiceCubit>().submit();
    }
  }
}
