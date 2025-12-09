import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/screens/products/cubit/product_cubit.dart';
import 'package:system_loja/screens/products/cubit/produto_state.dart';
import 'package:system_loja/screens/widgets/card_list_item.dart';

import '../../core/models/produto.dart';

/// Tela de cadastro e listagem de produtos.
///
/// Permite adicionar novos produtos, visualizar a lista de produtos
/// cadastrados e ver detalhes de cada produto.
class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({super.key});

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  // Constantes
  static const String _tituloAppBar = 'Cadastro de Produto';
  static const String _tituloNovoProduto = 'Novo Produto';
  static const String _tituloProdutosCadastrados = 'Produtos Cadastrados';
  static const String _mensagemNenhumProduto = 'Nenhum produto cadastrado';
  static const String _mensagemSucesso = 'cadastrado com sucesso!';
  static const String _mensagemPrecoInvalido = 'Erro: Preço inválido!';
  static const String _mensagemEstoqueInvalido = 'Erro: Estoque inválido!';

  late final ProductCubit _produtoCubit = ProductCubit();
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _codigoController = TextEditingController();
  final _precoController = TextEditingController();
  final _estoqueController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _categoriaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _produtoCubit,
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          List<Produto> produtos = [];
          if (state is ProductStateInsertSuccess) {
            produtos.addAll(state.produtos);
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text(_tituloAppBar),
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
                            _tituloNovoProduto,
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
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
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
                            _tituloProdutosCadastrados,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (produtos.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(32.0),
                                child: Text(
                                  _mensagemNenhumProduto,
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
                              itemCount: produtos.length,
                              itemBuilder: (context, index) {
                                final produto = produtos[index];
                                return CardListItem(
                                  colorAvatar: Colors.green,
                                  title: produto.nome,
                                  subTitle:
                                      'Código: ${produto.codigo}\nR\$ ${produto.preco.toStringAsFixed(2)} - Estoque: ${produto.estoque}',
                                  onTap: () {
                                    _mostrarDetalhesProduto(produto);
                                  },
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
        },
      ),
    );
  }

  @override
  void dispose() {
    _produtoCubit.close();
    _nomeController.dispose();
    _codigoController.dispose();
    _precoController.dispose();
    _estoqueController.dispose();
    _descricaoController.dispose();
    _categoriaController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _produtoCubit.newId();
  }

  /// Adiciona um novo produto após validação.
  void _adicionarProduto() {
    if (!_formKey.currentState!.validate()) return;

    final codigo = _codigoController.text.trim();
    int? codigoInt = int.tryParse(codigo);
    if (codigoInt == null) {
      _mostrarErro('Erro: Código inválido!');
      return;
    }
    _produtoCubit.findByCode(codigoInt);

    // Valida e converte valores numéricos
    final preco = _validarPreco(_precoController.text.trim());
    if (preco == null) {
      _mostrarErro(_mensagemPrecoInvalido);
      return;
    }

    final estoque = _validarEstoque(_estoqueController.text.trim());
    if (estoque == null) {
      _mostrarErro(_mensagemEstoqueInvalido);
      return;
    }

    // Cria e adiciona produto
    final produto = Produto(
      id: 0, // ID será gerado automaticamente
      nome: _nomeController.text.trim(),
      codigo: codigo,
      preco: preco,
      estoque: estoque,
      descricao: _descricaoController.text.trim(),
      categoria: _categoriaController.text.trim(),
    );

    _produtoCubit.adicionarProduto(produto);
    _mostrarSucesso('Produto "${produto.nome}" $_mensagemSucesso');
    _limparFormulario();
  }

  /// Constrói uma linha de detalhe com label e valor.
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

  /// Limpa todos os campos do formulário.
  void _limparFormulario() {
    _formKey.currentState!.reset();
    _nomeController.clear();
    _codigoController.clear();
    _precoController.clear();
    _estoqueController.clear();
    _descricaoController.clear();
    _categoriaController.clear();
  }

  /// Exibe um diálogo modal com os detalhes completos do produto.
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
              _buildDetailRow(
                'Preço',
                'R\$ ${produto.preco.toStringAsFixed(2)}',
              ),
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

  /// Exibe mensagem de erro em SnackBar.
  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem), backgroundColor: Colors.red),
    );
  }

  /// Exibe mensagem de sucesso em SnackBar.
  void _mostrarSucesso(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem), backgroundColor: Colors.green),
    );
  }

  /// Valida e converte o estoque.
  int? _validarEstoque(String texto) {
    final estoque = int.tryParse(texto);
    return (estoque != null && estoque >= 0) ? estoque : null;
  }

  /// Valida e converte o preço.
  double? _validarPreco(String texto) {
    final preco = double.tryParse(texto.replaceAll(',', '.'));
    return (preco != null && preco >= 0) ? preco : null;
  }
}
