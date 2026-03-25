import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/aplication/app_injection.dart';
import 'package:system_loja/core/interface/i_product_repository.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/screens/products/cubit/product_cubit.dart';
import 'package:system_loja/screens/products/cubit/product_state.dart';
import 'package:system_loja/screens/products/widgets/product_list.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';

/// Exibe a listagem de produtos cadastrados.
@RoutePage()
class ProductListScreen extends StatefulWidget implements AutoRouteWrapper {
  static final ValueNotifier<int> _reloadSignal = ValueNotifier<int>(0);

  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => ProductListScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ProductCubit>(
      create: (_) => ProductCubit(appInjection.get<IProductRepository>()),
      child: this,
    );
  }

  static void requestReload() {
    _reloadSignal.value++;
  }
}

class ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductStateError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red));
        }
      },
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final produtos = _extractProducts(state);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ProductList(products: produtos, onProductTap: _abrirEdicaoProduto),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    ProductListScreen._reloadSignal.removeListener(_reloadProducts);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ProductListScreen._reloadSignal.addListener(_reloadProducts);
  }

  Future<void> _abrirEdicaoProduto(Product produto) async {
    final changed = await context.router.push<bool>(ProductDetailRoute(product: produto));

    if (changed == true && mounted) {
      _reloadProducts();
    }
  }

  List<Product> _extractProducts(ProductState state) {
    return switch (state) {
      ProductStateInsertSuccess(:final produtos) => produtos,
      ProductStateUpdateSuccess(:final produtos) => produtos,
      ProductStateDeleteSuccess(:final produtos) => produtos,
      ProductStateLoaded(:final produtos) => produtos,
      _ => <Product>[],
    };
  }

  void _reloadProducts() {
    if (!mounted) {
      return;
    }
    context.read<ProductCubit>().loadAllProducts();
  }
}
