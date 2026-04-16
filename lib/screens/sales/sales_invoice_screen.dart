import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/models/invoice_type.dart';
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
import 'package:system_loja/screens/widgets/empty_widget.dart';

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
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(child: InvoiceNumberField()),
                          const SizedBox(width: 8),
                          Tooltip(
                            message: 'Gerar número automaticamente',
                            child: IconButton(
                              onPressed: () => context.read<SalesInvoiceCubit>().toggleAutoInvoiceNumber(),
                              icon: const Icon(Icons.generating_tokens_outlined),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 16)),
                    SliverToBoxAdapter(
                      child: BlocSelector<SalesInvoiceCubit, SalesInvoiceState, InvoiceType>(
                        selector: (state) => state.form.invoiceType,
                        builder: (context, invoiceType) {
                          return InvoiceTypeSegmented(
                            invoiceType: invoiceType,
                            onChanged: context.read<SalesInvoiceCubit>().setInvoiceType,
                          );
                        },
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 16)),
                    SliverToBoxAdapter(
                      child: BlocSelector<SalesInvoiceCubit, SalesInvoiceState, PersonSelection?>(
                        selector: (state) => state.form.person,
                        builder: (context, person) {
                          return DropdownButtonFormField<PersonSelection>(
                            initialValue: person,
                            decoration: InputDecoration(
                              labelText: 'Cliente ou Empresa *',
                              border: const OutlineInputBorder(),
                              prefixIcon: Icon(person?.icon ?? Icons.person_search),
                            ),
                            items: _personOptions.map((p) {
                              return DropdownMenuItem(
                                value: p,
                                child: Text(
                                  '${p.displayName} (${p.document})',
                                  overflow: TextOverflow.ellipsis,
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
                          );
                        },
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 16)),
                    SliverToBoxAdapter(
                      child: BlocSelector<SalesInvoiceCubit, SalesInvoiceState, PaymentMethodType?>(
                        selector: (state) => state.form.paymentMethod,
                        builder: (context, paymentMethod) {
                          return DropdownButtonFormField<PaymentMethodType>(
                            initialValue: paymentMethod,
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
                          );
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
                    BlocBuilder<SalesInvoiceCubit, SalesInvoiceState>(
                      buildWhen: (previous, current) =>
                          previous.form.linesByProductId != current.form.linesByProductId ||
                          previous.form.orderedProductIds != current.form.orderedProductIds,
                      builder: (context, state) {
                        final orderedLines = state.form.buildOrderedLines();
                        if (orderedLines.isEmpty) {
                          return const SliverToBoxAdapter(
                            child: EmptyWidget(
                              message: 'Nenhum item adicionado',
                              icon: Icons.remove_shopping_cart,
                            ),
                          );
                        }
                        return SliverList.builder(
                          itemCount: orderedLines.length,
                          itemBuilder: (context, index) {
                            final line = orderedLines[index];
                            return InvoiceLineTile(
                              entry: line,
                              onDelete: () => context.read<SalesInvoiceCubit>().removeLine(line.product.id),
                            );
                          },
                        );
                      },
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                    SliverToBoxAdapter(
                      child: BlocSelector<SalesInvoiceCubit, SalesInvoiceState, double>(
                        selector: (state) => state.form.computeTotal(),
                        builder: (context, total) {
                          return InvoiceTotalBar(total: total);
                        },
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                    SliverToBoxAdapter(
                      child: BlocSelector<SalesInvoiceCubit, SalesInvoiceState, bool>(
                        selector: (state) => state.form.isSubmitting,
                        builder: (context, isSubmitting) {
                          return ElevatedButton(
                            onPressed: isSubmitting ? null : _onSave,
                            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                            child: isSubmitting
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : const Text('Salvar Nota Fiscal', style: TextStyle(fontSize: 16)),
                          );
                        },
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 32)),
                  ],
                ),
              ),
            ],
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
