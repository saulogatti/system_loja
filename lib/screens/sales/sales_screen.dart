import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/screens/sales/sales_cubit.dart';
import 'package:system_loja/screens/sales/sales_state.dart';
import 'package:system_loja/screens/widgets/card_list_item.dart';

import '../../core/models/customer.dart';
import '../../core/models/invoice.dart';
import '../../core/models/produto.dart';

class SalesView extends StatefulWidget {
  const SalesView({super.key});

  @override
  State<SalesView> createState() => _SalesViewState();
}

// Form screen for creating a new nota fiscal
class _SalesInvoiceScreen extends StatefulWidget {
  final Map<int, Customer> customers;
  final SalesCubit salesCubit;
  final List<Produto> products;
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
  final List<Map<String, dynamic>> _itensSelecionados = [];

  @override
  Widget build(BuildContext context) {
    final valorTotal = _itensSelecionados.fold<double>(0, (sum, item) {
      final produto = item['produto'] as Produto;
      final quantidade = item['quantidade'] as int;
      return sum + (produto.preco * quantidade);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Nota Fiscal'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
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
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Número da nota é obrigatório';
                  }
                  return null;
                },
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
                  hintText: 'Dinheiro, Cartão, Pix, etc.',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Forma de pagamento é obrigatória';
                  }
                  return null;
                },
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
              if (_itensSelecionados.isEmpty)
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
                ..._itensSelecionados.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final produto = item['produto'] as Produto;
                  final quantidade = item['quantidade'] as int;
                  final subtotal = produto.preco * quantidade;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(produto.nome),
                      subtitle: Text(
                        '${quantidade}x R\$ ${produto.preco.toStringAsFixed(2)} = R\$ ${subtotal.toStringAsFixed(2)}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _itensSelecionados.removeAt(index);
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
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Valor Total:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$ ${valorTotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
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
                child: const Text(
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

  void _adicionarItem() async {
    final produto = await showDialog<Produto>(
      context: context,
      builder: (context) => _SelecionarProdutoDialog(produtos: widget.products),
    );

    if (produto != null) {
      final quantidade = await _solicitarQuantidade(produto);
      if (quantidade != null && quantidade > 0) {
        if (quantidade > produto.estoque) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Estoque insuficiente! Disponível: ${produto.estoque}',
              ),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        setState(() {
          _itensSelecionados.add({
            'produto': produto,
            'quantidade': quantidade,
          });
        });
      }
    }
  }

  void _salvarNotaFiscal() async {
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

      if (_itensSelecionados.isEmpty) {
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

      final itens = _itensSelecionados.map((item) {
        final produto = item['produto'] as Produto;
        final quantidade = item['quantidade'] as int;
        return InvoiceItem(
          productId: produto.id, // ID não é mais null por construção
          productName: produto.nome,
          productCode: produto.codigo,
          quantity: quantidade,
          unitPrice: produto.preco,
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

  Future<int?> _solicitarQuantidade(Produto produto) async {
    final controller = TextEditingController();
    final quantidade = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quantidade de ${produto.nome}'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Quantidade (Estoque: ${produto.estoque})',
            border: const OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final qtd = int.tryParse(controller.text.trim());
              Navigator.pop(context, qtd);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
    controller.dispose();
    return quantidade;
  }
}

class _SalesViewState extends State<SalesView> {
  List<Produto> _produtoManager = [];
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
      body: BlocListener<SalesCubit, SalesState>(
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
              _produtoManager = state.products;
            case SalesLoading():
              // TODO: Implementar um dialog ou Overlay de loading (acho melhor um Overlay...)
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
            // TODO: Pensar sobre implementar um dialog ou Overlay de loading (acho melhor um Overlay...)
          }
        },
        child: Column(
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
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _mapToNotaFiscal.length,
                      itemBuilder: (context, index) {
                        final nf = _mapToNotaFiscal.values.elementAt(index);
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

  void _adicionarNotaFiscal() async {
    if (_mapCustomers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro: Nenhum cliente cadastrado!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_produtoManager.isEmpty) {
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
          products: _produtoManager,
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
  final List<Produto> produtos;

  const _SelecionarProdutoDialog({required this.produtos});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecionar Produto'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: produtos.length,
          itemBuilder: (context, index) {
            final produto = produtos[index];
            return ListTile(
              title: Text(produto.nome),
              subtitle: Text(
                'R\$ ${produto.preco.toStringAsFixed(2)} - Estoque: ${produto.estoque}',
              ),
              onTap: () => Navigator.pop(context, produto),
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
