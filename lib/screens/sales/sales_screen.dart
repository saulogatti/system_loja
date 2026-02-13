import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart';
import 'package:system_loja/screens/sales/cubit/sales_state.dart';
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
                  content: Text(
                    'Erro ao carregar notas fiscais! ${state.message}',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              break;
            case SalesLoadProductsFailure():
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Erro ao carregar produtos! ${state.message}'),
                  backgroundColor: Colors.red,
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
          final totalValue = invoices.fold<double>(
            0.0,
            (sum, invoice) => sum + invoice.data.totalValue,
          );

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
                            color: Colors.black.withValues(alpha: 0.1),
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
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Valor Total das Vendas',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'R\$ ${totalValue.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${invoices.length} ${invoices.length == 1 ? 'nota fiscal' : 'notas fiscais'}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.9),
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
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Nenhuma nota fiscal cadastrada',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 350,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 1.3,
                                ),
                            itemCount: invoices.length,
                            itemBuilder: (context, index) {
                              final nf = invoices[index];
                              return _buildInvoiceCard(nf);
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
    if (_mapCustomers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro: Nenhum cliente cadastrado!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_productList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro: Nenhum produto cadastrado!'),
          backgroundColor: Colors.red,
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
      ),
    );

    if (result == true) {
      setState(() {});
    }
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  /// Constrói um card visual para exibir informações da nota fiscal.
  ///
  /// Exibe número da nota, cliente e valor total em um formato de card
  /// Material 3 com ícone e cores informativas.
  Widget _buildInvoiceCard(Invoice nf) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => _mostrarDetalhesNota(nf),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.receipt_long,
                      size: 28,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NF ${nf.data.invoiceNumber}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'ID: ${nf.id}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          nf.data.customerName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${nf.data.items.length} ${nf.data.items.length == 1 ? 'item' : 'itens'}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'R\$ ${nf.data.totalValue.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarDetalhesNota(Invoice nf) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Nota Fiscal'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('ID', nf.id.toString()),
              _buildDetailRow('Número', nf.data.invoiceNumber),
              _buildDetailRow('Cliente', nf.data.customerName),
              _buildDetailRow('CPF', nf.data.customerCpf),
              _buildDetailRow(
                'Valor Total',
                'R\$ ${nf.data.totalValue.toStringAsFixed(2)}',
              ),
              _buildDetailRow('Pagamento', nf.data.paymentMethod),
              _buildDetailRow(
                'Data de Emissão',
                nf.data.issueDate.toString().split('.')[0],
              ),
              const SizedBox(height: 16),
              const Text(
                'Itens:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              ...nf.data.items.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '${item.quantity}x ${item.productName} - R\$ ${item.totalValue.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
