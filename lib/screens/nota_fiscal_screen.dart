import 'package:flutter/material.dart';
import '../managers/nota_fiscal_manager.dart';
import '../managers/cliente_manager.dart';
import '../managers/produto_manager.dart';
import '../models/nota_fiscal.dart';
import '../models/cliente.dart';
import '../models/produto.dart';

class NotaFiscalScreen extends StatefulWidget {
  const NotaFiscalScreen({super.key});

  @override
  State<NotaFiscalScreen> createState() => _NotaFiscalScreenState();
}

class _NotaFiscalScreenState extends State<NotaFiscalScreen> {
  final NotaFiscalManager _manager = NotaFiscalManager();
  final ClienteManager _clienteManager = ClienteManager();
  final ProdutoManager _produtoManager = ProdutoManager();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Nota Fiscal'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: _manager.notasFiscais.isEmpty
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
                    itemCount: _manager.notasFiscais.length,
                    itemBuilder: (context, index) {
                      final nf = _manager.notasFiscais[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.orange,
                            child: Text(
                              'NF',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            'Nota: ${nf.numeroNota}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Cliente: ${nf.clienteNome}\nR\$ ${nf.valorTotal.toStringAsFixed(2)}',
                          ),
                          isThreeLine: true,
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            _mostrarDetalhesNota(nf);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _adicionarNotaFiscal(),
        icon: const Icon(Icons.add),
        label: const Text('Nova Nota Fiscal'),
      ),
    );
  }

  void _adicionarNotaFiscal() async {
    if (_clienteManager.clientes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro: Nenhum cliente cadastrado!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_produtoManager.produtos.isEmpty) {
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
        builder: (context) => _NotaFiscalFormScreen(
          clienteManager: _clienteManager,
          produtoManager: _produtoManager,
          notaFiscalManager: _manager,
        ),
      ),
    );

    if (result == true) {
      setState(() {});
    }
  }

  void _mostrarDetalhesNota(NotaFiscal nf) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Nota Fiscal ${nf.numeroNota}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('ID', nf.id.toString()),
              _buildDetailRow('Número', nf.numeroNota),
              _buildDetailRow('Cliente', nf.clienteNome),
              _buildDetailRow('CPF', nf.clienteCpf),
              _buildDetailRow('Valor Total', 'R\$ ${nf.valorTotal.toStringAsFixed(2)}'),
              _buildDetailRow('Pagamento', nf.formaPagamento),
              _buildDetailRow(
                'Data de Emissão',
                nf.dataEmissao.toString().split('.')[0],
              ),
              const SizedBox(height: 16),
              const Text(
                'Itens:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              ...nf.itens.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '${item.quantidade}x ${item.produtoNome} - R\$ ${item.valorTotal.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  )),
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
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// Form screen for creating a new nota fiscal
class _NotaFiscalFormScreen extends StatefulWidget {
  final ClienteManager clienteManager;
  final ProdutoManager produtoManager;
  final NotaFiscalManager notaFiscalManager;

  const _NotaFiscalFormScreen({
    required this.clienteManager,
    required this.produtoManager,
    required this.notaFiscalManager,
  });

  @override
  State<_NotaFiscalFormScreen> createState() => _NotaFiscalFormScreenState();
}

class _NotaFiscalFormScreenState extends State<_NotaFiscalFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numeroNotaController = TextEditingController();
  final _formaPagamentoController = TextEditingController();
  Cliente? _clienteSelecionado;
  final List<Map<String, dynamic>> _itensSelecionados = [];

  @override
  void dispose() {
    _numeroNotaController.dispose();
    _formaPagamentoController.dispose();
    super.dispose();
  }

  void _adicionarItem() async {
    final produto = await showDialog<Produto>(
      context: context,
      builder: (context) => _SelecionarProdutoDialog(
        produtos: widget.produtoManager.produtos,
      ),
    );

    if (produto != null) {
      final quantidade = await _solicitarQuantidade(produto);
      if (quantidade != null && quantidade > 0) {
        if (quantidade > produto.estoque) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Estoque insuficiente! Disponível: ${produto.estoque}'),
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

  void _salvarNotaFiscal() {
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
      if (widget.notaFiscalManager.notasFiscais.any((nf) => nf.numeroNota == numeroNota)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro: Número da nota já cadastrado!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final itens = _itensSelecionados.map((item) {
        final produto = item['produto'] as Produto;
        final quantidade = item['quantidade'] as int;
        return ItemNotaFiscal(
          produtoId: produto.id!,
          produtoNome: produto.nome,
          produtoCodigo: produto.codigo,
          quantidade: quantidade,
          precoUnitario: produto.preco,
        );
      }).toList();

      final notaFiscal = NotaFiscal(
        id: widget.notaFiscalManager.notasFiscais.isEmpty
            ? 1
            : widget.notaFiscalManager.notasFiscais
                .map((nf) => nf.id!)
                .reduce((a, b) => a > b ? a : b) + 1,
        numeroNota: numeroNota,
        clienteId: _clienteSelecionado!.id!,
        clienteNome: _clienteSelecionado!.nome,
        clienteCpf: _clienteSelecionado!.cpf,
        itens: itens,
        formaPagamento: _formaPagamentoController.text.trim(),
      );

      widget.notaFiscalManager.notasFiscais.add(notaFiscal);
      widget.notaFiscalManager.salvarDados();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nota Fiscal "$numeroNota" cadastrada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final valorTotal = _itensSelecionados.fold<double>(
      0,
      (sum, item) {
        final produto = item['produto'] as Produto;
        final quantidade = item['quantidade'] as int;
        return sum + (produto.preco * quantidade);
      },
    );

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
              DropdownButtonFormField<Cliente>(
                value: _clienteSelecionado,
                decoration: const InputDecoration(
                  labelText: 'Cliente *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                items: widget.clienteManager.clientes.map((cliente) {
                  return DropdownMenuItem(
                    value: cliente,
                    child: Text('${cliente.nome} (${cliente.cpf})'),
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
                    onPressed: _adicionarItem,
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
