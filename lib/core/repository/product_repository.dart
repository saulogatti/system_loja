import 'package:system_loja/core/models/produto.dart';
import 'package:system_loja/core/repository/default/base_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/storage/base_data_storage.dart';

class ProductRepository extends BaseRepository {
  /// Mapa estático de locks por caminho de arquivo, para serializar I/O

  ProductRepository();

  /// Remove um produto do armazenamento.
  ///
  /// [id] ID do produto a ser removido.
  /// Retorna resultado da operação de exclusão.
  Future<ExecutionResult<bool, String>> deleteProduct(int id) async {
    final result = await defaultDataStorage.delete(id);
    switch (result) {
      case ExecutionSucess():
        return ExecutionSucess(result.result);
      case ExecutionError():
        return ExecutionError(
          'Falha ao deletar produto com ID: $id - ${result.failure}',
        );
    }
  }

  /// Retorna a lista de produtos em cache, carregando do disco se vazia.

  Future<ExecutionResult<Produto, String>> findByCode(int codigo) async {
    final result = await defaultDataStorage.fetchById(codigo);
    switch (result) {
      case ExecutionError<PersistentDataStore, String>():
        return ExecutionError(
          'Erro ao buscar produto com código $codigo'
          'no armazenamento: ${result.failure}',
        );
      case ExecutionSucess<PersistentDataStore, String>():
        final data = result.result;
        final produto = Produto.fromJson(data.data);
        return ExecutionSucess(produto);
    }
  }

  /// Retorna uma cópia da lista de produtos atualmente carregada.
  ///
  /// A cópia protege o cache interno contra modificações acidentais
  /// feitas pelo chamador.
  Future<ExecutionResult<List<Produto>, String>> getProdutos() async {
    final result = await defaultDataStorage.loadAll();
    switch (result) {
      case ExecutionError<List<PersistentDataStore>, String>():
        return ExecutionError(
          'Erro ao carregar produtos do armazenamento: ${result.failure}',
        );
      case ExecutionSucess<List<PersistentDataStore>, String>():
        final dataList = result.result;
        final produtos = dataList
            .map((data) => Produto.fromJson(data.data))
            .toList(growable: false);
        return ExecutionSucess(produtos);
    }
  }

  /// Adiciona ou atualiza um produto na lista em memória e agenda persistência.
  ///
  /// Este método atualiza o cache interno e chama [salvarDadosSincronizado]
  /// para persistir as alterações de forma segura. Não aguarda o término da
  /// operação (fire-and-forget) — adaptar conforme necessidade do chamador.
  Future<ExecutionResult<bool, String>> salvarProduto(Produto produto) async {
    final result = await defaultDataStorage.save(
      PersistentDataStore(id: produto.id, data: produto.toJson()),
    );
    if (!result) {
      return ExecutionError('Falha ao salvar produto: ${produto.nome}');
    }
    return ExecutionSucess(result);
  }

  /// Atualiza um produto existente no armazenamento.
  ///
  /// [produto] Produto com os dados atualizados.
  /// Retorna resultado da operação de atualização.
  ///
  /// **Nota**: Este método utiliza internamente [salvarProduto], pois o storage
  /// não diferencia entre inserção e atualização (upsert pattern).
  Future<ExecutionResult<bool, String>> updateProduct(Produto produto) {
    return salvarProduto(produto);
  }
}
