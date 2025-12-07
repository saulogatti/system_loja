import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/managers/produto_manager.dart';
import 'package:system_loja/core/models/produto.dart';
import 'package:system_loja/screens/products/cubit/produto_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProdutoManager _manager;

  ProductCubit(this._manager)
    : super(ProductState.insertSuccess(produtos: _manager.getProdutos()));

  void adicionarProduto(Produto produto) {
    _manager.salvarProduto(produto);
    emit(ProductState.insertSuccess(produtos: _manager.getProdutos()));
  }

  void findByCode(int codigo) {
    try {
      final produto = _manager.findByCode(codigo);
      if (produto != null) {
        emit(ProductState.findByCodeSuccess(produto: produto));
      } else {
        emit(ProductState.findByCodeFailure(message: 'Produto não encontrado'));
      }
    } catch (e) {
      emit(ProductState.findByCodeFailure(message: 'Erro ao buscar produto'));
    }
  }

  void newId() {
    final newId = _manager.gerarNovoId();
    emit(ProductState.newIdGenerated(newId: newId));
  }
}
