import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/repository/product_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/screens/injection/app_injection.dart';
import 'package:system_loja/screens/products/cubit/product_state.dart';

/// Gerencia o estado da tela de produtos e operações com a base de dados.
///
/// Este Cubit é responsável por coordenar operações CRUD (criar, ler,
/// atualizar, deletar) de produtos, mantendo o estado sincronizado com
/// a [ProductRepository]. Emite estados que refletem o resultado de cada
/// operação para a UI.
class ProductCubit extends Cubit<ProductState> {
  /// Repositório utilizado para acessar dados de produtos.
  late final ProductRepository _manager =
      AppInjection.instance.productRepository;

  /// Inicializa o Cubit com estado de carregamento.
  ///
  /// Cria uma nova instância do repositório e carrega todos os produtos
  /// disponíveis na base de dados.
  ProductCubit() : super(ProductState.loading()) {
    loadAllProducts();
  }

  /// Adiciona um novo produto à base de dados.
  ///
  /// Cria um novo registro com os dados fornecidos, obtém o próximo ID
  /// disponível e emite um estado de sucesso ao concluir.
  ///
  /// Parâmetros:
  ///   - [nome]: Nome do produto.
  ///   - [codigo]: Código único do produto.
  ///   - [preco]: Preço unitário do produto.
  ///   - [estoque]: Quantidade disponível em estoque.
  ///   - [descricao]: Descrição detalhada do produto.
  ///   - [categoryId]: ID da categoria à qual o produto pertence.
  Future<void> adicionarProduto({
    required String nome,
    required String codigo,
    required double preco,
    required int estoque,
    required String descricao,
    int? categoryId,
    required bool codeGenerate,
  }) async {
    if (codeGenerate) {
      codigo = await _manager.generateProductCode();
    }
    final produto = Product(
      name: nome,
      code: codigo,
      price: preco,
      stockQuantity: estoque,
      description: descricao,
      categoryId: categoryId,
    );

    final resultSave = await _manager.salvarProduto(produto);
    switch (resultSave) {
      case ResultSuccess(result: final saved):
        if (!saved) {
          emit(
            ProductState.error(
              message: 'Erro ao adicionar produto: operação falhou',
            ),
          );
          return;
        }
        final result = await _manager.getProdutos();
        switch (result) {
          case ResultSuccess(result: final produtos):
            emit(ProductState.insertSuccess(produtos: produtos.toList()));
          case ResultError(resultError: final errorMessage):
            emit(
              ProductState.error(
                message: 'Erro ao adicionar produto: $errorMessage',
              ),
            );
        }
      case ResultError(resultError: final errorMessage):
        emit(
          ProductState.error(
            message: 'Erro ao adicionar produto: $errorMessage',
          ),
        );
    }
  }

  /// Remove um produto da base de dados.
  ///
  /// Exclui o registro identificado por [id] e recarrega a lista de produtos.
  /// Emite um estado de sucesso ao concluir a exclusão.
  ///
  /// Parâmetros:
  ///   - [id]: Identificador único do produto a ser removido.
  Future<void> deleteProduct(int id) async {
    final deleteResult = await _manager.deleteProduct(id);
    switch (deleteResult) {
      case ResultSuccess():
        final result = await _manager.getProdutos();
        switch (result) {
          case ResultSuccess(result: final produtos):
            emit(ProductState.deleteSuccess(produtos: produtos.toList()));
          case ResultError(resultError: final errorMessage):
            emit(
              ProductState.error(
                message:
                    'Erro ao carregar produtos após exclusão: $errorMessage',
              ),
            );
        }
      case ResultError(resultError: final errorMessage):
        emit(
          ProductState.error(message: 'Erro ao deletar produto: $errorMessage'),
        );
    }
  }

  /// Busca um produto pelo seu código.
  ///
  /// Realiza uma busca na base de dados pelo código do produto e emite
  /// um estado contendo o resultado da busca.
  ///
  /// Parâmetros:
  ///   - [codigo]: Código do produto a ser localizado.
  Future<void> findByCode(int codigo) async {
    // TODO implementar falta implementação na tela
    final result = await _manager.findByCode(codigo);
    switch (result) {
      case ResultSuccess(result: final produto):
        emit(
          ProductState.error(
            message: 'Funcionalidade não implementada: ${produto.name}',
          ),
        );

      case ResultError(resultError: final errorMessage):
        emit(
          ProductState.error(message: 'Erro ao buscar produto: $errorMessage'),
        );
    }
  }

  Future<void> loadAllProducts() async {
    final result = await _manager.getProdutos();
    switch (result) {
      case ResultSuccess(result: final produtos):
        emit(ProductState.loaded(produtos: produtos.toList()));
      case ResultError(resultError: final errorMessage):
        emit(
          ProductState.error(
            message: 'Erro ao carregar produtos: $errorMessage',
          ),
        );
    }
  }

  /// Atualiza um produto existente na base de dados.
  ///
  /// Modifica o registro do produto identificado pelo seu ID e recarrega
  /// a lista de produtos após a atualização.
  ///
  /// Parâmetros:
  ///   - [produto]: Objeto [Produto] contendo os dados atualizados.
  Future<void> updateProduct(Product produto) async {
    emit(ProductState.loading());
    final updateResult = await _manager.updateProduct(produto);
    switch (updateResult) {
      case ResultSuccess():
        final result = await _manager.getProdutos();
        switch (result) {
          case ResultSuccess(result: final produtos):
            emit(ProductState.updateSuccess(produtos: produtos.toList()));
          case ResultError(resultError: final errorMessage):
            emit(
              ProductState.error(
                message:
                    'Erro ao carregar produtos após atualização: $errorMessage',
              ),
            );
        }
      case ResultError(resultError: final errorMessage):
        emit(
          ProductState.error(
            message: 'Erro ao atualizar produto: $errorMessage',
          ),
        );
    }
  }
}
