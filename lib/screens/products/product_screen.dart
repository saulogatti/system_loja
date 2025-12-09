import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/screens/products/cubit/product_cubit.dart';
import 'package:system_loja/screens/products/cubit/produto_state.dart';
import 'package:system_loja/screens/products/product_detail_screen.dart';
import 'package:system_loja/screens/products/widgets/product_form.dart';
import 'package:system_loja/screens/products/widgets/product_list.dart';

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
      child: BlocListener<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductStateUpdateSuccess || state is ProductStateDeleteSuccess) {
            // Recarregar a lista após atualização ou exclusão
            _produtoCubit.loadAllProducts();
          }
        },
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            List<Produto> produtos = [];
            if (state is ProductStateInsertSuccess) {
              produtos.addAll(state.produtos);
            } else if (state is ProductStateUpdateSuccess) {
              produtos.addAll(state.produtos);
            } else if (state is ProductStateDeleteSuccess) {
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ProductForm(
                          formKey: _formKey,
                          nomeController: _nomeController,
                          codigoController: _codigoController,
                          precoController: _precoController,
                          estoqueController: _estoqueController,
                          descricaoController: _descricaoController,
                          categoriaController: _categoriaController,
                          onSubmit: _adicionarProduto,
                        ),
                        const SizedBox(height: 32),
                        ProductList(
                          produtos: produtos,
                          onProductTap: _mostrarDetalhesProduto,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        ),
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

  /// Navega para a tela de detalhes do produto.
  void _mostrarDetalhesProduto(Produto produto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: _produtoCubit,
          child: ProductDetailScreen(product: produto),
        ),
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
