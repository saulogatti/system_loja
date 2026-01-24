import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/screens/products/cubit/product_cubit.dart';
import 'package:system_loja/screens/products/cubit/product_state.dart';
import 'package:system_loja/screens/products/widgets/product_form.dart';
import 'package:system_loja/screens/products/widgets/product_list.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';


/// Tela de cadastro e listagem de produtos.
///
/// Permite adicionar novos produtos, visualizar a lista de produtos
/// cadastrados e ver detalhes de cada produto.
@RoutePage()
class ProductInfoScreen extends StatefulWidget implements AutoRouteWrapper {
  const ProductInfoScreen({super.key});

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ProductCubit>(
      create: (_) => ProductCubit(),
      child: this,
    );
  }
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  // Constantes
  static const String _tituloAppBar = 'Cadastro de Produto';
  static const String _mensagemSucesso = 'cadastrado com sucesso!';

  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _codigoController = TextEditingController();
  final _precoController = TextEditingController();
  final _estoqueController = TextEditingController();
  final _descricaoController = TextEditingController();
  int? _selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductStateUpdateSuccess ||
            state is ProductStateDeleteSuccess) {
          // Recarregar a lista após atualização ou exclusão
          context.read<ProductCubit>().loadAllProducts();
        } else if (state is ProductStateInsertSuccess) {
          _mostrarSucesso('Produto $_mensagemSucesso');
          _limparFormulario();
        } else if (state is ProductStateError) {
          _mostrarErro(state.message);
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
          } else if (state is ProductStateLoaded) {
            produtos.addAll(state.produtos);
          }
          return Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _tituloAppBar,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
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
                        selectedCategoryId: _selectedCategoryId,
                        onCategoryChanged: (categoryId) {
                          setState(() {
                            _selectedCategoryId = categoryId;
                          });
                        },
                        onSubmit: _adicionarProduto,
                        onGenerateCode: () {
                          final generatedCode = kStringGenerate;
                          _codigoController.text = generatedCode;
                        },
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
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // _produtoCubit.close();
    _nomeController.dispose();
    _codigoController.dispose();
    _precoController.dispose();
    _estoqueController.dispose();
    _descricaoController.dispose();
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

    // Converte valores já validados pelos validators
    // Os validators garantem que esses valores são parseáveis
    final preco = double.parse(_precoController.text.trim());
    final codigo = _codigoController.text.trim();
    final estoque = int.parse(_estoqueController.text.trim());
    final nome = _nomeController.text.trim();

    context.read<ProductCubit>().adicionarProduto(
      nome: nome,
      codigo: codigo,
      preco: preco,
      estoque: estoque,
      descricao: _descricaoController.text.trim(),
      categoryId: _selectedCategoryId,
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
    setState(() {
      _selectedCategoryId = null;
    });
  }

  /// Navega para a tela de detalhes do produto.
  void _mostrarDetalhesProduto(Product produto, List<Product> produtos) {
    context.router.root.push(
      ProductDetailRoute(product: produto, productList: produtos),
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
