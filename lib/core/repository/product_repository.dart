import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/database/dao/product_dao.dart';
import 'package:system_loja/screens/injection/app_injection.dart';

class ProductRepository {
  /// Mapa estático de locks por caminho de arquivo, para serializar I/O
  final ProductDao defaultDataStorage =
      AppInjection.instance.appDatabase.productDao; //
  ProductRepository();

  /// Remove um produto do armazenamento.
  ///
  /// [id] ID do produto a ser removido.
  /// Retorna resultado da operação de exclusão.
  Future<ExecutionResult<bool, String>> deleteProduct(int id) async {
    final result = await defaultDataStorage.remove(id);
    switch (result) {
      case true:
        return ExecutionSucess(result);
      case false:
        return ExecutionError(
          'Falha ao deletar produto com ID: $id - não encontrado',
        );
    }
  }

  /// Retorna a lista de produtos em cache, carregando do disco se vazia.

  Future<ExecutionResult<Product, String>> findByCode(int codigo) async {
    final result = await defaultDataStorage.getById(codigo);
    if (result != null) {
      return ExecutionSucess(result);
    } else {
      return ExecutionError('Produto com código $codigo não encontrado');
    }
  }

  /// Retorna uma cópia da lista de produtos atualmente carregada.
  ///
  /// A cópia protege o cache interno contra modificações acidentais
  /// feitas pelo chamador.
  Future<ExecutionResult<List<Product>, String>> getProdutos() async {
    final result = await defaultDataStorage.getAll();
    return ExecutionSucess(result);
  }

  /// Adiciona ou atualiza um produto na lista em memória e agenda persistência.
  ///
  /// Este método atualiza o cache interno e chama [salvarDadosSincronizado]
  /// para persistir as alterações de forma segura. Não aguarda o término da
  /// operação (fire-and-forget) — adaptar conforme necessidade do chamador.
  Future<ExecutionResult<bool, String>> salvarProduto(Product produto) async {
    final result = await defaultDataStorage.insertProduct(produto);
    if (result == 0) {
      return ExecutionError('Falha ao salvar produto: ${produto.name}');
    }
    return ExecutionSucess(result > 0);
  }

  /// Atualiza um produto existente no armazenamento.
  ///
  /// [produto] Produto com os dados atualizados.
  /// Retorna resultado da operação de atualização.
  ///
  /// **Nota**: Este método utiliza internamente [salvarProduto], pois o storage
  /// não diferencia entre inserção e atualização (upsert pattern).
  Future<ExecutionResult<bool, String>> updateProduct(Product produto) async {
    final result = await defaultDataStorage.updateProduct(produto);
    return ExecutionSucess(result);
  }
}
