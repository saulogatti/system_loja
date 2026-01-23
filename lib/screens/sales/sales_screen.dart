import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/utils/input_formatters.dart';
import 'package:system_loja/core/utils/validators.dart';
import 'package:system_loja/screens/sales/sales_cubit.dart';
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

class _AddSaleTemp {
  final List<_ProductSelection> product;

  _AddSaleTemp({required this.product});
}

class _ProductSelection {
  final Product product;
  final int quantity;

  _ProductSelection({required this.product, required this.quantity});
}

// Form screen for creating a new nota fiscal
class _SalesInvoiceScreen extends StatefulWidget {
  final Map<int, Customer> customers;
  final SalesCubit salesCubit;
  final List<Product> products;
  const _SalesInvoiceScreen({
    // required this.produtoManager,
    required this.customers,
    required this.salesCubit,
    required this.products,
  });

  @override
  State<_SalesInvoiceScreen> createState() => _SalesInvoiceScreenState();
}

class _SalesInvoiceScreenState extends State<_SalesInvoiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numeroNotaController = TextEditingController();
  final _formaPagamentoController = TextEditingController();
  Customer? _clienteSelecionado;
  final _AddSaleTemp _itensSelecionados = _AddSaleTemp(product: []);

  @override
  Widget build(BuildContext context) {
    final valorTotal = _itensSelecionados.product.fold<double>(0.0, (
      previousValue,
      item,
    ) {
      final productItem = item.product;
      final quantidade = item.quantity;
      return previousValue + (productItem.price * quantidade);
    });

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _numeroNotaController,
                decoration: const InputDecoration(
                  labelText: 'Número da Nota *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                  helperText: 'Ex: NF-001, 12345',
                ),
                validator: (value) => validateRequired(value, 'Número da nota'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Customer>(
                initialValue: _clienteSelecionado,
                decoration: const InputDecoration(
                  labelText: 'Cliente *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                items: widget.customers.values.map((cliente) {
                  return DropdownMenuItem(
                    value: cliente,
                    child: Text('${cliente.name} (${cliente.cpf})'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _clienteSelecionado = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione um cliente';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _formaPagamentoController,
                decoration: const InputDecoration(
                  labelText: 'Forma de Pagamento *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.payment),
                  helperText: 'Ex: Dinheiro, Cartão, Pix',
                ),
                validator: (value) =>
                    validateRequired(value, 'Forma de pagamento'),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Itens',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed: _addItem,
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar Item'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_itensSelecionados.product.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      'Nenhum item adicionado',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              else
                ..._itensSelecionados.product.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final productItem = item.product;
                  final quantidade = item.quantity;
                  final subtotal = productItem.price * quantidade;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(productItem.name),
                      subtitle: Text(
                        '${quantidade}x R\$ ${productItem.price.toStringAsFixed(2)} = R\$ ${subtotal.toStringAsFixed(2)}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _itensSelecionados.product.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                }),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Valor Total:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$ ${valorTotal.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _salvarNotaFiscal,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                child: Text(
                  'Salvar Nota Fiscal',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _numeroNotaController.dispose();
    _formaPagamentoController.dispose();
    super.dispose();
  }

  void _addItem() {
    _adicionarItem();
  }

  Future<void> _adicionarItem() async {
    final product = await showDialog<Product>(
      context: context,
      builder: (context) => _SelecionarProdutoDialog(products: widget.products),
    );

    if (product != null) {
      final quantidade = await _solicitarQuantidade(product);
      if (quantidade != null && quantidade > 0) {
        if (quantidade > product.stockQuantity) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Estoque insuficiente! Disponível: ${product.stockQuantity}',
              ),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        setState(() {
          _itensSelecionados.product.add(
            _ProductSelection(product: product, quantity: quantidade),
          );
        });
      }
    }
  }

  Future<void> _salvarNotaFiscal() async {
    if (_formKey.currentState!.validate()) {
      if (_clienteSelecionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro: Selecione um cliente!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_itensSelecionados.product.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro: Adicione pelo menos um item!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final numeroNota = _numeroNotaController.text.trim();

      // Check if invoice number already exists
      // if (widget.notaFiscalManager.notasFiscais.any(
      //   (nf) => nf.numeroNota == numeroNota,
      // )) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Erro: Número da nota já cadastrado!'),
      //       backgroundColor: Colors.red,
      //     ),
      //   );
      //   return;
      // }

      final itens = _itensSelecionados.product.map((item) {
        final product = item.product;
        final quantity = item.quantity;
        return InvoiceItem(
          productId: product.id, // ID não é mais null por construção
          productName: product.name,
          productCode: product.code,
          quantity: quantity,
          unitPrice: product.price,
        );
      }).toList();

      final notaFiscal = InvoiceData(
        invoiceNumber: numeroNota,
        customerId: _clienteSelecionado!.id,
        customerName: _clienteSelecionado!.name,
        customerCpf: _clienteSelecionado!.cpf,
        items: itens,
        paymentMethod: _formaPagamentoController.text.trim(),
      );

      widget.salesCubit.registerSale(notaFiscal);
    }
  }

  Future<int?> _solicitarQuantidade(Product product) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final quantidade = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quantidade de ${product.name}'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [QuantityInputFormatter()],
            decoration: InputDecoration(
              labelText: 'Quantidade *',
              helperText: 'Estoque disponível: ${product.stockQuantity}',
              border: const OutlineInputBorder(),
            ),
            autofocus: true,
            validator: (value) {
              // Usa o validador padrão
              final error = validateQuantity(value);
              if (error != null) return error;

              // Validação adicional para estoque
              final qtd = int.parse(value!.trim());
              if (qtd > product.stockQuantity) {
                return 'Quantidade maior que o estoque disponível';
              }

              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final qtd = int.parse(controller.text.trim());
                Navigator.pop(context, qtd);
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );

    return quantidade;
  }
}

class _SalesViewState extends State<SalesView> {
  List<Product> _productManager = [];
  final SalesCubit _salesCubit = SalesCubit();

  Map<int, Invoice> _mapToNotaFiscal = {};

  Map<int, Customer> _mapCustomers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Nota Fiscal'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocConsumer<SalesCubit, SalesState>(
        bloc: _salesCubit,
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
              _productManager = state.products;
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
              Navigator.pop(context, true);
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
        onPressed: _adicionarNotaFiscal,
        icon: const Icon(Icons.add),
        label: const Text('Nova Nota Fiscal'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _salesCubit.loadAllCustomers();
    _salesCubit.loadSales();
    _salesCubit.loadProducts();
  }

  Future<void> _adicionarNotaFiscal() async {
    if (_mapCustomers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro: Nenhum cliente cadastrado!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_productManager.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro: Nenhum produto cadastrado!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _SalesInvoiceScreen(
          products: _productManager,
          salesCubit: _salesCubit,
          customers: _mapCustomers,
        ),
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

// Dialog to select a product
class _SelecionarProdutoDialog extends StatelessWidget {
  final List<Product> products;

  const _SelecionarProdutoDialog({required this.products});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecionar Produto'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text(
                'R\$ ${product.price.toStringAsFixed(2)} - Estoque: ${product.stockQuantity}',
              ),
              onTap: () => Navigator.pop(context, product),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
