import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/core/models/invoice_type.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/utils/input_formatters.dart';
import 'package:system_loja/core/utils/validators.dart';
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart';
import 'package:system_loja/screens/utils/constants.dart';

@RoutePage()
class SalesInvoiceScreen extends StatefulWidget {
  final List<PaymentMethodType> paymentMethods;
  final Map<int, Customer> customers;
  final Map<int, Company> companies;
  final SalesCubit salesCubit;
  final List<Product> products;

  const SalesInvoiceScreen({
    super.key,
    required this.paymentMethods,
    required this.customers,
    required this.companies,
    required this.salesCubit,
    required this.products,
  });

  @override
  State<SalesInvoiceScreen> createState() => _SalesInvoiceScreenState();
}

class _AddSaleTemp {
  final Map<int, _ProductSelection> product;

  _AddSaleTemp({required this.product});
}

class _ProductSelection {
  final Product product;
  int quantity;

  _ProductSelection({required this.product, required this.quantity});
}

class _SalesInvoiceScreenState extends State<SalesInvoiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numeroNotaController = TextEditingController();
  PaymentMethodType? _paymentType;
  Customer? _clienteSelecionado;
  Company? _empresaSelecionada;
  InvoiceType _invoiceType = InvoiceType.exit;
  final _AddSaleTemp _itensSelecionados = _AddSaleTemp(product: {});

  /// Controla se a geração automática do número da nota está habilitada.
  bool _enableCodeGeneration = false;

  @override
  Widget build(BuildContext context) {
    final valorTotal = _itensSelecionados.product.values.fold<double>(0.0, (previousValue, item) {
      final productItem = item.product;
      final quantidade = item.quantity;
      return previousValue + (productItem.price * quantidade);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Nota Fiscal'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        leading: AutoLeadingButton(),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: _enableCodeGeneration,
                      controller: _numeroNotaController,
                      decoration: const InputDecoration(
                        labelText: 'Número da Nota *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.numbers),
                      ),
                      validator: (value) => validateRequired(value, 'Número da nota'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _enableCodeGeneration = !_enableCodeGeneration;
                        _numeroNotaController.text = _enableCodeGeneration ? kStringGenerate : '';
                      });
                    },
                    icon: const Icon(Icons.generating_tokens_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SegmentedButton<InvoiceType>(
                segments: const [
                  ButtonSegment(
                    value: InvoiceType.exit,
                    label: Text('Saída (Venda)'),
                    icon: Icon(Icons.arrow_upward),
                  ),
                  ButtonSegment(
                    value: InvoiceType.entry,
                    label: Text('Entrada (Compra)'),
                    icon: Icon(Icons.arrow_downward),
                  ),
                ],
                selected: {_invoiceType},
                onSelectionChanged: (selection) {
                  setState(() {
                    _invoiceType = selection.first;
                    // Limpa a seleção do lado oposto ao alterar o tipo
                    _clienteSelecionado = null;
                    _empresaSelecionada = null;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Customer>(
                initialValue: _clienteSelecionado,
                decoration: const InputDecoration(
                  labelText: 'Cliente',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  helperText: 'Preencha cliente ou empresa *',
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
                    if (value != null) {
                      _empresaSelecionada = null;
                    }
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Company>(
                initialValue: _empresaSelecionada,
                decoration: const InputDecoration(
                  labelText: 'Empresa',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.business),
                  helperText: 'Preencha cliente ou empresa *',
                ),
                items: widget.companies.values.map((empresa) {
                  return DropdownMenuItem(
                    value: empresa,
                    child: Text('${empresa.name} (${empresa.cnpj})'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _empresaSelecionada = value;
                    if (value != null) {
                      _clienteSelecionado = null;
                    }
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<PaymentMethodType>(
                initialValue: _paymentType,
                decoration: const InputDecoration(
                  labelText: 'Forma de Pagamento *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.payment),
                  helperText: 'Ex: Dinheiro, Cartão, Pix',
                ),
                items: widget.paymentMethods.map((paymentMethod) {
                  return DropdownMenuItem(value: paymentMethod, child: Text(paymentMethod.name));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _paymentType = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione uma forma de pagamento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Itens', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                    child: Text('Nenhum item adicionado', style: TextStyle(color: Colors.grey)),
                  ),
                )
              else
                ..._itensSelecionados.product.entries.map((entry) {
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
                            _itensSelecionados.product.remove(index);
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
                    const Text('Valor Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                child: const Text('Salvar Nota Fiscal', style: TextStyle(fontSize: 16)),
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
      int? quantidade = await _solicitarQuantidade(product);
      if (quantidade != null && quantidade > 0) {
        if (_itensSelecionados.product.containsKey(product.id)) {
          quantidade = _itensSelecionados.product[product.id]!.quantity + quantidade;
        }
        if (quantidade > product.stockQuantity) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Estoque insuficiente! Disponível: ${product.stockQuantity}'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        setState(() {
          _itensSelecionados.product[product.id] = _ProductSelection(product: product, quantity: quantidade!);
        });
      }
    }
  }

  Future<void> _salvarNotaFiscal() async {
    if (_formKey.currentState!.validate()) {
      if (_clienteSelecionado == null && _empresaSelecionada == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro: Selecione um cliente ou empresa!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_clienteSelecionado != null && _empresaSelecionada != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro: Selecione apenas cliente ou empresa!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_itensSelecionados.product.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro: Adicione pelo menos um item!'), backgroundColor: Colors.red),
        );
        return;
      }

      final numeroNota = _numeroNotaController.text.trim();

      final itens = _itensSelecionados.product.values.map((productSelection) {
        final product = productSelection.product;
        final quantity = productSelection.quantity;
        return InvoiceItem(
          productId: product.id,
          productName: product.name,
          productCode: product.code,
          quantity: quantity,
          unitPrice: product.price,
        );
      }).toList();

      final notaFiscal = InvoiceData(
        invoiceNumber: numeroNota,
        type: _invoiceType,
        customerId: _clienteSelecionado?.id,
        customerName: _clienteSelecionado?.name,
        customerCpf: _clienteSelecionado?.cpf,
        companyId: _empresaSelecionada?.id,
        items: itens,
        paymentMethod: _paymentType?.name ?? '',
      );

      widget.salesCubit.registerSale(notaFiscal, _enableCodeGeneration);
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
              final error = validateQuantity(value);
              if (error != null) return error;

              final qtd = int.parse(value!.trim());
              if (qtd > product.stockQuantity) {
                return 'Quantidade maior que o estoque disponível';
              }

              return null;
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
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
              subtitle: Text('R\$ ${product.price.toStringAsFixed(2)} - Estoque: ${product.stockQuantity}'),
              onTap: () => Navigator.pop(context, product),
            );
          },
        ),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar'))],
    );
  }
}
