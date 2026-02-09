import 'package:system_loja/core/interface/i_product_repository.dart';
import 'package:system_loja/core/managers/system_error_manager.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/services/code_generator_service.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/database/dao/product_dao.dart';

class ProductRepository implements IProductRepository {
  /// Mapa estático de locks por caminho de arquivo, para serializar I/O
  final ProductDao _productDao;
  final CodeGeneratorService _codeGeneratorService;

  ProductRepository({
    required ProductDao productDao,
    required CodeGeneratorService codeGeneratorService,
  }) : _productDao = productDao,
       _codeGeneratorService = codeGeneratorService;

  /// Remove um produto do armazenamento.
  ///
  /// [id] ID do produto a ser removido.
  /// Retorna resultado da operação de exclusão.
  @override
  Future<ResultStatus<bool, String>> deleteProduct(int id) async {
    try {
      final result = await _productDao.remove(id);
      switch (result) {
        case true:
          return ResultSuccess(result);
        case false:
          return ResultError(
            'Falha ao deletar produto com ID: $id - não encontrado',
          );
      }
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultError('Erro ao deletar produto com ID: $id ');
    }
  }

  /// Retorna uma cópia da lista de produtos atualmente carregada.
  ///
  /// A cópia protege o cache interno contra modificações acidentais
  /// feitas pelo chamador.
  @override
  Future<ResultStatus<List<Product>, String>> fetchProducts() async {
    try {
      final result = await _productDao.getAll();
      return ResultSuccess(result);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultError('Erro ao carregar produtos');
    }
  }

  /// Retorna a lista de produtos em cache, carregando do disco se vazia.

  @override
  Future<ResultStatus<Product, String>> findByCode(int codigo) async {
    try {
      final result = await _productDao.getById(codigo);
      if (result != null) {
        return ResultSuccess(result);
      } else {
        return ResultError('Produto com código $codigo não encontrado');
      }
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultError('Erro ao buscar produto com código $codigo ');
    }
  }

  /// Gera um código único para um novo produto.
  ///
  /// Retorna um código no formato PRD-YYYYMMDD-NNNN que não existe no banco.
  @override
  Future<String> generateProductCode() async {
    return await _codeGeneratorService.generateProductCode();
  }

  /// Salva um produto no banco de dados.
  ///
  /// [product] Produto a ser salvo.
  /// Retorna resultado da operação de salvamento.
  @override
  Future<ResultStatus<bool, String>> saveProduct(Product product) async {
    try {
      final result = await _productDao.insertProduct(product);
      if (result <= 0) {
        return ResultError('Falha ao salvar produto: ${product.name}');
      }
      return ResultSuccess(result > 0);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultError('Falha ao salvar produto: ${product.name}');
    }
  }

  /// Atualiza um produto existente no armazenamento.
  ///
  /// [product] Produto com os dados atualizados.
  /// Retorna resultado da operação de atualização.
  @override
  Future<ResultStatus<bool, String>> updateProduct(Product product) async {
    try {
      final result = await _productDao.updateProduct(product);
      return ResultSuccess(result);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultError('Falha ao atualizar produto: ${product.name}');
    }
  }

  /// Valida um código de produto fornecido pelo usuário.
  ///
  /// [code] Código a ser validado.
  /// Retorna resultado da validação com mensagem descritiva.
  @override
  Future<ResultStatus<bool, String>> validateProductCode(String code) async {
    final validationResult = await _codeGeneratorService.validateProductCode(
      code,
    );

    if (validationResult.isValid) {
      return ResultSuccess(true);
    } else {
      return ResultError(validationResult.message);
    }
  }
}
