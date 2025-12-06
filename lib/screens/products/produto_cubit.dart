import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/managers/produto_manager.dart';
import 'package:system_loja/core/models/produto.dart';

class ProdutoState {
  const ProdutoState({this.produtos = const []});

  final List<Produto> produtos;
}

class ProdutoCubit extends Cubit<ProdutoState> {
  final ProdutoManager _manager;

  ProdutoCubit(this._manager)
    : super(ProdutoState(produtos: _manager.getProdutos()));

  void adicionarProduto(Produto produto) {
    _manager.salvarProduto(produto);
    emit(ProdutoState(produtos: _manager.getProdutos()));
  }

  Produto? buscarPorCodigo(String codigo) {
    try {
      return state.produtos.firstWhere((produto) => produto.codigo == codigo);
    } catch (_) {
      return null;
    }
  }

  int gerarNovoId() => _manager.gerarNovoId();
}
