import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart';
import 'package:system_loja/screens/sales/sales_state.dart';
import 'package:system_loja/screens/widgets/card_list_item.dart';
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
  // REMOVIDO: final SalesCubit _salesCubit = SalesCubit();

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
            case SalesLoadedProducts():
              _productList = state.products;
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
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: _mapToNotaFiscal.isEmpty
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
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: _mapToNotaFiscal.length,
                            itemBuilder: (context, index) {
                              final nf = _mapToNotaFiscal.values.elementAt(
                                index,
                              );
                              return CardListItem(
                                colorAvatar: Colors.orange,
                                title: 'Nota: ${nf.data.invoiceNumber}',
                                subTitle:
                                    'Cliente: ${nf.data.customerName}\nR\$ ${nf.data.totalValue.toStringAsFixed(2)}',
                                onTap: () {
                                  _mostrarDetalhesNota(nf);
                                },
                              );
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

  void _mostrarDetalhesNota(Invoice nf) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Nota Fiscal ${nf.data.invoiceNumber}'),
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
