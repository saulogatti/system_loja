import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/utils/result_status.dart';

/// Interface que define o contrato para operações de repositório de produtos.
///
/// Esta interface abstrai as operações CRUD (Create, Read, Update, Delete)
/// para entidades [Product], permitindo diferentes implementações de
/// persistência (Drift, JSON, etc.).
///
/// Inclui funcionalidades especiais como geração automática de código de
/// produto e validação de códigos únicos.
///
/// Exemplo de uso:
/// ```dart
/// final repository = appInjection.get<ProductRepository>();
///
/// // Gerar código automático
/// final codigo = await repository.generateProductCode();
///
/// // Criar produto
/// final produto = Product(
///   code: codigo,
///   name: 'Notebook Dell',
///   price: 3500.00,
/// );
///
/// final resultado = await repository.saveProduct(produto);
/// if (resultado.isSuccessful) {
///   print('Produto salvo com sucesso');
/// }
/// ```
///
/// Veja também:
/// - [Product] - modelo de domínio de produto
/// - [ResultStatus] - tipo de retorno para operações
abstract interface class IProductRepository {
  /// Remove um produto do sistema pelo ID.
  ///
  /// Parâmetros:
  /// - [id]: ID único do produto a ser removido
  ///
  /// Retorna:
  /// - [ResultStatus] com true se removido com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> deleteProduct(int id);

  /// Retorna todos os produtos cadastrados no sistema.
  ///
  /// Retorna:
  /// - [ResultStatus] com lista de produtos ou mensagem de erro
  Future<ResultStatus<List<Product>, String>> fetchProducts();

  /// Busca um produto específico pelo código.
  ///
  /// Parâmetros:
  /// - [codigo]: Código único do produto
  ///
  /// Retorna:
  /// - [ResultStatus] com o produto encontrado ou mensagem de erro
  Future<ResultStatus<Product, String>> findByCode(int codigo);

  /// Gera um novo código de produto único.
  ///
  /// O código é gerado automaticamente seguindo a sequência do sistema,
  /// garantindo que não haja duplicação.
  ///
  /// Retorna:
  /// - String com o novo código gerado (geralmente numérico sequencial)
  Future<String> generateProductCode();

  /// Salva um novo produto no sistema.
  ///
  /// Para produtos sem ID ou com ID = 0, será criado um novo registro.
  /// O código do produto deve ser único.
  ///
  /// Parâmetros:
  /// - [product]: Objeto Product a ser salvo
  ///
  /// Retorna:
  /// - [ResultStatus] com true se salvo com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> saveProduct(Product product);

  /// Atualiza os dados de um produto existente.
  ///
  /// O produto deve ter um ID válido.
  ///
  /// Parâmetros:
  /// - [product]: Objeto Product com dados atualizados
  ///
  /// Retorna:
  /// - [ResultStatus] com true se atualizado com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> updateProduct(Product product);

  /// Valida se um código de produto é único no sistema.
  ///
  /// Útil para verificação antes de criar ou atualizar produtos.
  ///
  /// Parâmetros:
  /// - [code]: Código a ser validado
  ///
  /// Retorna:
  /// - [ResultStatus] com true se o código é válido (não existe) ou mensagem de erro
  Future<ResultStatus<bool, String>> validateProductCode(String code);
}
