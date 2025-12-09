import 'package:system_loja/core/models/produto.dart';
import 'package:system_loja/core/repository/default/repository_manager.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/storage/storage_data.dart';

class ProductRepository extends RepositoryManager {
  /// Mapa estático de locks por caminho de arquivo, para serializar I/O

  ProductRepository();

  /// Retorna a lista de produtos em cache, carregando do disco se vazia.

  Future<OperationResult<Produto, String>> findByCode(int codigo) async {
    final result = await defaultDataStorage.fetchById(codigo);
    switch (result) {
      case OperationError<PersistentDataStore, String>():
        return OperationError(
          'Erro ao buscar produto com código $codigo'
          'no armazenamento: ${result.error}',
        );
      case OperationSuccess<PersistentDataStore, String>():
        final data = result.result;
        final produto = Produto.fromJson(data.data);
        return OperationSuccess(produto);
    }
  }

  /// Retorna uma cópia da lista de produtos atualmente carregada.
  ///
  /// A cópia protege o cache interno contra modificações acidentais
  /// feitas pelo chamador.
  Future<OperationResult<List<Produto>, String>> getProdutos() async {
    final result = await defaultDataStorage.loadAll();
    switch (result) {
      case OperationError<List<PersistentDataStore>, String>():
        return OperationError(
          'Erro ao carregar produtos do armazenamento: ${result.error}',
        );
      case OperationSuccess<List<PersistentDataStore>, String>():
        final dataList = result.result;
        final produtos = dataList
            .map((data) => Produto.fromJson(data.data))
            .toList(growable: false);
        return OperationSuccess(produtos);
    }
  }

  /// Adiciona ou atualiza um produto na lista em memória e agenda persistência.
  ///
  /// Este método atualiza o cache interno e chama [salvarDadosSincronizado]
  /// para persistir as alterações de forma segura. Não aguarda o término da
  /// operação (fire-and-forget) — adaptar conforme necessidade do chamador.
  Future<OperationResult<bool, String>> salvarProduto(Produto produto) async {
    final result = await defaultDataStorage.save(
      PersistentDataStore(id: produto.id, data: produto.toJson()),
    );
    if (!result) {
      return OperationError('Falha ao salvar produto: ${produto.nome}');
    }
    return OperationSuccess(result);
  }

  /// Atualiza um produto existente no armazenamento.
  ///
  /// [produto] Produto com os dados atualizados.
  /// Retorna resultado da operação de atualização.
  Future<OperationResult<bool, String>> updateProduct(Produto produto) async {
    final result = await defaultDataStorage.save(
      PersistentDataStore(id: produto.id, data: produto.toJson()),
    );
    if (!result) {
      return OperationError('Falha ao atualizar produto: ${produto.nome}');
    }
    return OperationSuccess(result);
  }

  /// Remove um produto do armazenamento.
  ///
  /// [id] ID do produto a ser removido.
  /// Retorna resultado da operação de exclusão.
  Future<OperationResult<bool, String>> deleteProduct(int id) async {
    final result = await defaultDataStorage.deleteById(id);
    if (!result) {
      return OperationError('Falha ao deletar produto com ID: $id');
    }
    return OperationSuccess(result);
  }
}
