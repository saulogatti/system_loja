import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/screens/products/cubit/product_cubit.dart';
import 'package:system_loja/screens/products/cubit/product_state.dart';
import 'package:system_loja/screens/products/product_detail_screen.dart';
import 'package:system_loja/screens/products/widgets/product_form.dart';
import 'package:system_loja/screens/products/widgets/product_list.dart';

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
          if (state is ProductStateUpdateSuccess ||
              state is ProductStateDeleteSuccess) {
            // Recarregar a lista após atualização ou exclusão
            _produtoCubit.loadAllProducts();
          }
        },
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            final List<Product> produtos = [];
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
                            products: produtos,
                          ),
                          const SizedBox(height: 32),
                          ProductList(
                            products: produtos,
                            onProductTap: (produto) =>
                                _mostrarDetalhesProduto(produto, produtos),
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
    // Valida o formulário usando os validadores
    // Os validadores já exibem mensagens específicas para cada campo
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      // Converte valores já validados pelos validators
      // Os validators garantem que esses valores são parseáveis
      final preco = double.parse(_precoController.text.trim());
      final codigo = _codigoController.text.trim();
      final estoque = int.parse(_estoqueController.text.trim());
      final nome = _nomeController.text.trim();

      _produtoCubit.adicionarProduto(
        nome: nome,
        codigo: codigo,
        preco: preco,
        estoque: estoque,
        descricao: _descricaoController.text.trim(),
        categoria: _categoriaController.text.trim(),
      );
      _mostrarSucesso('Produto "$nome" $_mensagemSucesso');
      _limparFormulario();
    } on FormatException catch (e) {
      // Isto não deve acontecer devido aos validators, mas tratamos por segurança
      _mostrarErro(
        'Erro de formato ao processar dados numéricos: ${e.message}',
      );
    } catch (e) {
      // Captura erros inesperados do repositório/banco de dados
      _mostrarErro('Erro ao salvar produto: ${e.toString()}');
    }
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
  void _mostrarDetalhesProduto(Product produto, List<Product> produtos) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: _produtoCubit,
          child: ProductDetailScreen(product: produto, productList: produtos),
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
}
