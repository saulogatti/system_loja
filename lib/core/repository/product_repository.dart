import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/services/code_generator_service.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/database/dao/product_dao.dart';
import 'package:system_loja/screens/injection/app_injection.dart';

class ProductRepository {
  /// Mapa estático de locks por caminho de arquivo, para serializar I/O
  final ProductDao defaultDataStorage =
      AppInjection.instance.appDatabase.productDao; //
  final CodeGeneratorService _codeGeneratorService =
      AppInjection.instance.codeGeneratorService;
      
  ProductRepository();

  /// Remove um produto do armazenamento.
  ///
  /// [id] ID do produto a ser removido.
  /// Retorna resultado da operação de exclusão.
  Future<ResultStatus<bool, String>> deleteProduct(int id) async {
    final result = await defaultDataStorage.remove(id);
    switch (result) {
      case true:
        return ResultSuccess(result);
      case false:
        return ResultError(
          'Falha ao deletar produto com ID: $id - não encontrado',
        );
    }
  }

  /// Retorna a lista de produtos em cache, carregando do disco se vazia.

  Future<ResultStatus<Product, String>> findByCode(int codigo) async {
    final result = await defaultDataStorage.getById(codigo);
    if (result != null) {
      return ResultSuccess(result);
    } else {
      return ResultError('Produto com código $codigo não encontrado');
    }
  }

  /// Retorna uma cópia da lista de produtos atualmente carregada.
  ///
  /// A cópia protege o cache interno contra modificações acidentais
  /// feitas pelo chamador.
  Future<ResultStatus<List<Product>, String>> getProdutos() async {
    final result = await defaultDataStorage.getAll();
    return ResultSuccess(result);
  }

  /// Adiciona ou atualiza um produto na lista em memória e agenda persistência.
  ///
  /// Este método atualiza o cache interno e chama [salvarDadosSincronizado]
  /// para persistir as alterações de forma segura. Não aguarda o término da
  /// operação (fire-and-forget) — adaptar conforme necessidade do chamador.
  Future<ResultStatus<bool, String>> salvarProduto(Product produto) async {
    try {
      final result = await defaultDataStorage.insertProduct(produto);
      if (result <= 0) {
        return ResultError('Falha ao salvar produto: ${produto.name}');
      }
      return ResultSuccess(result > 0);
    } on Exception catch (err) {
      return ResultError(
        'Falha ao salvar produto: ${produto.name} - ${err.toString()}',
      );
    }
  }

  /// Atualiza um produto existente no armazenamento.
  ///
  /// [produto] Produto com os dados atualizados.
  /// Retorna resultado da operação de atualização.
  ///
  /// **Nota**: Este método utiliza internamente [salvarProduto], pois o storage
  /// não diferencia entre inserção e atualização (upsert pattern).
  Future<ResultStatus<bool, String>> updateProduct(Product produto) async {
    final result = await defaultDataStorage.updateProduct(produto);
    return ResultSuccess(result);
  }

  /// Gera um código único para um novo produto.
  ///
  /// Retorna um código no formato PRD-YYYYMMDD-NNNN que não existe no banco.
  Future<String> generateProductCode() async {
    return await _codeGeneratorService.generateProductCode();
  }

  /// Valida um código de produto fornecido pelo usuário.
  ///
  /// [code] Código a ser validado.
  /// Retorna resultado da validação com mensagem descritiva.
  Future<ResultStatus<bool, String>> validateProductCode(String code) async {
    final validationResult = await _codeGeneratorService.validateProductCode(code);
    
    if (validationResult.isValid) {
      return ResultSuccess(true);
    } else {
      return ResultError(validationResult.message);
    }
  }
}
