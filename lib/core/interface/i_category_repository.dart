import 'package:system_loja/core/models/category.dart';
import 'package:system_loja/core/utils/command_result.dart';

/// Interface que define o contrato para operações de repositório de categorias.
///
/// Esta interface abstrai as operações CRUD (Create, Read, Update, Delete)
/// para entidades [Category], permitindo diferentes implementações de
/// persistência (Drift, JSON, etc.).
///
/// Todas as operações retornam [ResultStatus] para tratamento type-safe
/// de erros, exceto [isCategoryInUse] que retorna um booleano direto.
///
/// Exemplo de uso:
/// ```dart
/// final repository = AppInjection.instance.categoryRepository;
/// final resultado = await repository.getCategoryById(1);
/// if (resultado.isSuccessful) {
///   final category = resultado.asSuccess;
///   print('Categoria: ${category.name}');
/// }
/// ```
///
/// Veja também:
/// - [Category] - modelo de domínio de categoria
/// - [ResultStatus] - tipo de retorno para operações
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
  Future<ResultStatus<int, String>> createCategory({
    required String name,
    String? description,
  });

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
  Future<ResultStatus<List<Category>, String>> getAllCategories();

  /// Busca uma categoria específica pelo ID.
  ///
  /// Parâmetros:
  /// - [id]: ID único da categoria
  ///
  /// Retorna:
  /// - [ResultStatus] com a categoria encontrada ou mensagem de erro
  Future<ResultStatus<Category, String>> getCategoryById(int id);

  /// Busca uma categoria pelo nome.
  ///
  /// Útil para verificar se uma categoria com determinado nome já existe.
  ///
  /// Parâmetros:
  /// - [name]: Nome da categoria a ser buscada
  ///
  /// Retorna:
  /// - [ResultStatus] com a categoria encontrada ou mensagem de erro
  Future<ResultStatus<Category, String>> getCategoryByName(String name);

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
