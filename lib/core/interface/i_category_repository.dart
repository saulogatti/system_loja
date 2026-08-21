import 'package:system_loja/core/models/product_category.dart';
import 'package:system_loja/core/utils/result_status.dart';

/// Contrato de persistência de categorias de produto exposto à UI.
///
/// {@category contratos}
/// {@subCategory Cadastros}
///
/// CRUD de [ProductCategory] via Drift. A maioria das operações retorna
/// [ResultStatus]; [isCategoryInUse] devolve `bool` direto.
///
/// Resolver com `appInjection.get<ICategoryRepository>()`.
///
/// ```dart
/// final repository = appInjection.get<ICategoryRepository>();
/// final resultado = await repository.getCategoryById(1);
/// resultado.when(
///   onSuccess: (category) => print(category.name),
///   onError: (mensagem) => print(mensagem),
/// );
/// ```
///
/// Veja também:
/// - [ProductCategory] — modelo de domínio
/// - [ResultStatus] — retorno das operações
abstract interface class ICategoryRepository {
  /// Cria uma nova categoria no sistema.
  ///
  /// Retorna o ID da categoria criada em caso de sucesso ou uma mensagem
  /// de erro em caso de falha.
  ///
  /// Parâmetros:
  /// - [name]: Nome da categoria (obrigatório)
  /// - [description]: Descrição opcional da categoria
  ///
  /// Retorna:
  /// - [ResultStatus] com ID da categoria criada ou mensagem de erro
  Future<ResultStatus<int, String>> createCategory({required String name, String? description});

  /// Remove uma categoria do sistema pelo ID.
  ///
  /// Antes de remover, verifique se a categoria está em uso usando
  /// [isCategoryInUse] para evitar problemas de integridade referencial.
  ///
  /// Parâmetros:
  /// - [id]: ID único da categoria a ser removida
  ///
  /// Retorna:
  /// - [ResultStatus] com true se removida com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> deleteCategory(int id);

  /// Retorna todas as categorias cadastradas no sistema.
  ///
  /// Retorna:
  /// - [ResultStatus] com lista de categorias ou mensagem de erro
  Future<ResultStatus<List<ProductCategory>, String>> getAllCategories();

  /// Busca uma categoria específica pelo ID.
  ///
  /// Parâmetros:
  /// - [id]: ID único da categoria
  ///
  /// Retorna:
  /// - [ResultStatus] com a categoria encontrada ou mensagem de erro
  Future<ResultStatus<ProductCategory, String>> getCategoryById(int id);

  /// Busca uma categoria pelo nome.
  ///
  /// Útil para verificar se uma categoria com determinado nome já existe.
  ///
  /// Parâmetros:
  /// - [name]: Nome da categoria a ser buscada
  ///
  /// Retorna:
  /// - [ResultStatus] com a categoria encontrada ou mensagem de erro
  Future<ResultStatus<ProductCategory, String>> getCategoryByName(String name);

  /// Verifica se a categoria está sendo utilizada por produtos.
  ///
  /// Use este método antes de deletar uma categoria para garantir
  /// integridade referencial.
  ///
  /// Parâmetros:
  /// - [categoryId]: ID da categoria a ser verificada
  ///
  /// Retorna:
  /// - true se a categoria está em uso, false caso contrário
  Future<bool> isCategoryInUse(int categoryId);

  /// Atualiza os dados de uma categoria existente.
  ///
  /// Parâmetros:
  /// - [id]: ID da categoria a ser atualizada
  /// - [name]: Novo nome da categoria
  /// - [description]: Nova descrição da categoria (opcional)
  ///
  /// Retorna:
  /// - [ResultStatus] com true se atualizada com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> updateCategory({
    required int id,
    required String name,
    String? description,
  });
}
