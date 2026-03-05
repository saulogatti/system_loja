import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart';
import 'package:system_loja/screens/sales/cubit/sales_state.dart';
import 'package:system_loja/screens/sales/widgets/invoice_card.dart';
import 'package:system_loja/screens/sales/widgets/invoice_overview_bottom_sheet.dart';
import 'package:system_loja/screens/widgets/loading_overlay.dart';

import '../../core/models/customer.dart';
import '../../core/models/invoice.dart';

@RoutePage()
class SalesView extends StatefulWidget {
  const SalesView({super.key});

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  List<Product> _productList = [];
  List<PaymentMethodType> _paymentMethods = [];

  Map<int, Invoice> _mapToNotaFiscal = {};

  Map<int, Customer> _mapCustomers = {};
  Map<int, Company> _mapCompanies = {};

  @override
  Widget build(BuildContext context) {
    // Usar o SalesCubit do contexto (Provider global)
    final salesCubit = context.read<SalesCubit>();

    return Scaffold(
      body: BlocConsumer<SalesCubit, SalesState>(
        // REMOVIDO: bloc: _salesCubit,
        listener: (context, state) {
          switch (state) {
            case SalesInitial():
              break;

            case SalesError():
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Erro ao carregar notas fiscais! ${state.message}'),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
              break;
            case SalesLoadProductsFailure():
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Erro ao carregar produtos! ${state.message}'),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
              break;
            case SalesLoaded():
              setState(() {
                _mapToNotaFiscal = state.items;
              });

              break;
            case SalesLoadedCustomers():
              _mapCustomers = state.customers;
            case SalesLoadedAll():
              _productList = state.products;
              _mapCustomers = state.customers;
              _mapCompanies = state.companies;
              _mapToNotaFiscal = state.invoices;
              _paymentMethods = state.paymentMethods;
              break;
            case SalesLoading():
              // Loading overlay é exibido através do builder
              break;
            case SalesSaved():
              _mapToNotaFiscal = state.items;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Nota Fiscal "${state.items.values.last.data.invoiceNumber}" cadastrada com sucesso!',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              // CORRIGIDO: Usar AutoRouter
              context.router.maybePop(true);
              break;
            case SalesLoadingProducts():
              // Loading overlay é exibido através do builder
              break;
          }
        },
        builder: (context, state) {
          final invoices = _mapToNotaFiscal.values.toList(growable: false);
          final totalValue = invoices.fold<double>(0.0, (sum, invoice) => sum + invoice.data.totalValue);

          return Stack(
            children: [
              Column(
                children: [
                  if (invoices.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.primaryContainer,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.analytics_outlined,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Valor Total das Vendas',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'R\$ ${totalValue.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${invoices.length} ${invoices.length == 1 ? 'nota fiscal' : 'notas fiscais'}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: invoices.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.receipt_long,
                                  size: 80,
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Nenhuma nota fiscal cadastrada',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.all(10),
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 350,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1.3,
                            ),
                            itemCount: invoices.length,
                            itemBuilder: (context, index) {
                              final nf = invoices[index];
                              return InvoiceCard(invoice: nf, onTap: () => _mostrarDetalhesNota(nf));
                            },
                          ),
                  ),
                ],
              ),
              // Exibe o overlay de loading quando necessário
              if (state is SalesLoading || state is SalesLoadingProducts)
                LoadingOverlay(
                  message: switch (state) {
                    SalesLoading() => 'Carregando vendas...',
                    SalesLoadingProducts() => 'Carregando produtos...',
                    _ => 'Carregando...',
                  },
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _adicionarNotaFiscal(salesCubit),
        icon: const Icon(Icons.add),
        label: const Text('Nova Nota Fiscal'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Usar o cubit do contexto após o primeiro frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final salesCubit = context.read<SalesCubit>();
      salesCubit.loadAllCustomers();
      salesCubit.loadSales();
      salesCubit.loadProducts();
    });
  }

  Future<void> _adicionarNotaFiscal(SalesCubit salesCubit) async {
    if (_mapCustomers.isEmpty && _mapCompanies.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Erro: Nenhum cliente ou empresa cadastrada!'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    if (_productList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Erro: Nenhum produto cadastrado!'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    final result = await context.router.root.push(
      SalesInvoiceRoute(
        paymentMethods: _paymentMethods,
        products: _productList,
        salesCubit: salesCubit,
        customers: _mapCustomers,
        companies: _mapCompanies,
      ),
    );

    if (result == true) {
      setState(() {});
    }
  }

  void _mostrarDetalhesNota(Invoice nf) {
    InvoiceOverviewBottomSheet.show(context, nf);
  }
}
