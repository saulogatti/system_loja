import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/application/app_injection.dart';
import 'package:system_loja/core/interface/i_product_repository.dart';
import 'package:system_loja/screens/products/cubit/product_cubit.dart';
import 'package:system_loja/screens/products/cubit/product_state.dart';
import 'package:system_loja/screens/products/widgets/product_form.dart';

/// Tela de cadastro de produtos.
///
/// Esta tela é aberta via navegação para cadastrar um novo produto.
@RoutePage()
class ProductInfoScreen extends StatefulWidget implements AutoRouteWrapper {
  const ProductInfoScreen({super.key});

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ProductCubit>(
      create: (_) => ProductCubit(appInjection.get<IProductRepository>()),
      child: this,
    );
  }
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  static const String _mensagemSucesso = 'Produto cadastrado com sucesso!';

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
        if (state is ProductStateInsertSuccess) {
          _mostrarSucesso(_mensagemSucesso);
          context.router.maybePop(true);
        }
        if (state is ProductStateError) {
          _mostrarErro(state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Produto'),
          leading: const AutoLeadingButton(),
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            final isLoading = state is ProductStateLoading;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ProductForm(
                isLoading: isLoading,
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
              ),
            );
          },
        ),
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
  }

  /// Adiciona um novo produto após validação.
  void _adicionarProduto(bool generatedCode) {
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
      codeGenerate: generatedCode,
    );
  }

  /// Exibe mensagem de erro em SnackBar.
  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem), backgroundColor: Theme.of(context).colorScheme.error),
    );
  }

  /// Exibe mensagem de sucesso em SnackBar.
  void _mostrarSucesso(String mensagem) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensagem), backgroundColor: Colors.green));
  }
}
