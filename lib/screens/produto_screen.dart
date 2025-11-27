import 'package:flutter/material.dart';
import '../core/managers/produto_manager.dart';
import '../core/models/produto.dart';

class ProdutoScreen extends StatefulWidget {
  const ProdutoScreen({super.key});

  @override
  State<ProdutoScreen> createState() => _ProdutoScreenState();
}

class _ProdutoScreenState extends State<ProdutoScreen> {
  final ProdutoManager _manager = ProdutoManager();
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _codigoController = TextEditingController();
  final _precoController = TextEditingController();
  final _estoqueController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _categoriaController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _codigoController.dispose();
    _precoController.dispose();
    _estoqueController.dispose();
    _descricaoController.dispose();
    _categoriaController.dispose();
    super.dispose();
  }

  void _adicionarProduto() async {
    if (_formKey.currentState!.validate()) {
      final codigo = _codigoController.text.trim();

      // Check if product code already exists
      if (_manager.produtos.any((p) => p.codigo == codigo)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro: Código já cadastrado!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final preco = double.tryParse(_precoController.text.trim().replaceAll(',', '.'));
      final estoque = int.tryParse(_estoqueController.text.trim());

      if (preco == null || preco < 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro: Preço inválido!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (estoque == null || estoque < 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro: Estoque inválido!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final produto = Produto(
        id: _manager.produtos.isEmpty
            ? 1
            : _manager.produtos.map((p) => p.id!).reduce((a, b) => a > b ? a : b) + 1,
        nome: _nomeController.text.trim(),
        codigo: codigo,
        preco: preco,
        estoque: estoque,
        descricao: _descricaoController.text.trim(),
        categoria: _categoriaController.text.trim(),
      );

      _manager.produtos.add(produto);
      await _manager.salvarDadosSincronizado();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Produto "${produto.nome}" cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      _formKey.currentState!.reset();
      _nomeController.clear();
      _codigoController.clear();
      _precoController.clear();
      _estoqueController.clear();
      _descricaoController.clear();
      _categoriaController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Produto'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Novo Produto',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do Produto *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.inventory_2),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nome é obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _codigoController,
                      decoration: const InputDecoration(
                        labelText: 'Código *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.qr_code),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Código é obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _precoController,
                            decoration: const InputDecoration(
                              labelText: 'Preço (R\$) *',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.attach_money),
                            ),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Preço é obrigatório';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _estoqueController,
                            decoration: const InputDecoration(
                              labelText: 'Estoque *',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.inventory),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Estoque é obrigatório';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _categoriaController,
                      decoration: const InputDecoration(
                        labelText: 'Categoria',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.category),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descricaoController,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _adicionarProduto,
                      icon: const Icon(Icons.add),
                      label: const Text('Adicionar Produto'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Produtos Cadastrados',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_manager.produtos.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text(
                            'Nenhum produto cadastrado',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _manager.produtos.length,
                        itemBuilder: (context, index) {
                          final produto = _manager.produtos[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Text(
                                  produto.nome[0].toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                produto.nome,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Código: ${produto.codigo}\nR\$ ${produto.preco.toStringAsFixed(2)} - Estoque: ${produto.estoque}',
                              ),
                              isThreeLine: true,
                              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
                                _mostrarDetalhesProduto(produto);
                              },
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarDetalhesProduto(Produto produto) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(produto.nome),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('ID', produto.id.toString()),
              _buildDetailRow('Código', produto.codigo),
              _buildDetailRow('Preço', 'R\$ ${produto.preco.toStringAsFixed(2)}'),
              _buildDetailRow('Estoque', produto.estoque.toString()),
              _buildDetailRow('Categoria', produto.categoria),
              _buildDetailRow('Descrição', produto.descricao),
              _buildDetailRow(
                'Data de Cadastro',
                produto.dataCadastro.toString().split('.')[0],
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
