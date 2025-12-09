import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/produto.dart';
import 'package:system_loja/core/repository/product_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/screens/products/cubit/produto_state.dart';

class ProductCubit extends Cubit<ProductState> {
  late ProductRepository _manager;

  ProductCubit() : super(ProductState.loading()) {
    _manager = ProductRepository();
    loadAllProducts();
  }

  void adicionarProduto(Produto produto) async {
    await _manager.salvarProduto(produto);
    final result = await _manager.getProdutos();
    switch (result) {
      case OperationSuccess(result: final produtos):
        emit(ProductState.insertSuccess(produtos: produtos.toList()));
      case OperationError(error: final errorMessage):
        emit(
          ProductState.findByCodeFailure(
            message: 'Erro ao adicionar produto: $errorMessage',
          ),
        );
    }
  }

  void findByCode(int codigo) async {
    final result = await _manager.findByCode(codigo);
    switch (result) {
      case OperationSuccess(result: final produto):
        emit(ProductState.findByCodeSuccess(produto: produto));
        return;
      case OperationError(error: final errorMessage):
        emit(
          ProductState.findByCodeFailure(
            message: 'Erro ao buscar produto: $errorMessage',
          ),
        );
        return;
    }
  }

  void loadAllProducts() async {
    final result = await _manager.getProdutos();
    switch (result) {
      case OperationSuccess(result: final produtos):
        emit(ProductState.insertSuccess(produtos: produtos.toList()));
      case OperationError(error: final errorMessage):
        emit(
          ProductState.findByCodeFailure(
            message: 'Erro ao carregar produtos: $errorMessage',
          ),
        );
    }
  }

  void newId() async {
    final newId = await _manager.obtainNextId();
    emit(ProductState.newIdGenerated(newId: newId));
  }
}
