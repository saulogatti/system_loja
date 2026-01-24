import 'package:system_loja/core/models/category.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/database/dao/category_dao.dart';
import 'package:system_loja/screens/injection/app_injection.dart';

/// Repositório para gerenciar operações de categorias de produtos.
///
/// Fornece uma camada de abstração entre a UI e o acesso a dados,
/// encapsulando a lógica de negócios relacionada às categorias.
class CategoryRepository {
  final CategoryDao _dao = AppInjection.instance.appDatabase.categoryDao;

  CategoryRepository();

  /// Cria uma nova categoria.
  ///
  /// [name] Nome da categoria (obrigatório e único).
  /// [description] Descrição opcional da categoria.
  /// Retorna o ID da categoria criada ou erro.
  Future<ResultStatus<int, String>> createCategory({
    required String name,
    String? description,
  }) async {
    try {
      // Validar se o nome já existe
      final exists = await _dao.nameExists(name);
      if (exists) {
        return ResultError('Já existe uma categoria com o nome "$name"');
      }

      final id = await _dao.insertCategory(
        name: name,
        description: description,
      );
      return ResultSuccess(id);
    } on Exception catch (e) {
      return ResultError('Erro ao criar categoria: ${e.toString()}');
    }
  }

  /// Remove uma categoria.
  ///
  /// [id] Identificador da categoria a ser removida.
  /// Retorna sucesso ou erro.
  ///
  /// Nota: A remoção falhará se houver produtos associados à categoria.
  Future<ResultStatus<bool, String>> deleteCategory(int id) async {
    try {
      // Verificar se há produtos associados
      final hasProducts = await _dao.hasProducts(id);
      if (hasProducts) {
        return ResultError(
          'Não é possível remover esta categoria pois há produtos associados a ela',
        );
      }

      final success = await _dao.remove(id);
      if (success) {
        return ResultSuccess(true);
      }
      return ResultError('Categoria não encontrada');
    } on Exception catch (e) {
      return ResultError('Erro ao remover categoria: ${e.toString()}');
    }
  }

  /// Retorna todas as categorias cadastradas.
  ///
  /// As categorias são ordenadas por nome.
  Future<ResultStatus<List<Category>, String>> getAllCategories() async {
    try {
      final records = await _dao.getAll();

      return ResultSuccess(records);
    } on Exception catch (e) {
      return ResultError('Erro ao carregar categorias: ${e.toString()}');
    }
  }

  /// Busca uma categoria por ID.
  ///
  /// [id] Identificador único da categoria.
  /// Retorna a categoria encontrada ou erro se não existir.
  Future<ResultStatus<Category, String>> getCategoryById(int id) async {
    try {
      final record = await _dao.getById(id);
      if (record != null) {
        return ResultSuccess(record);
      }
      return ResultError('Categoria com ID $id não encontrada');
    } on Exception catch (e) {
      return ResultError('Erro ao buscar categoria: ${e.toString()}');
    }
  }

  /// Busca uma categoria por nome.
  ///
  /// [name] Nome da categoria a ser buscada.
  /// Retorna a categoria encontrada ou erro se não existir.
  Future<ResultStatus<Category, String>> getCategoryByName(String name) async {
    try {
      final record = await _dao.getByName(name);
      if (record != null) {
        return ResultSuccess(record);
      }
      return ResultError('Categoria "$name" não encontrada');
    } on Exception catch (e) {
      return ResultError('Erro ao buscar categoria: ${e.toString()}');
    }
  }

  /// Verifica se uma categoria está em uso por algum produto.
  ///
  /// [categoryId] ID da categoria a ser verificada.
  /// Retorna true se a categoria está em uso.
  Future<bool> isCategoryInUse(int categoryId) async {
    return await _dao.hasProducts(categoryId);
  }

  /// Atualiza uma categoria existente.
  ///
  /// [id] Identificador da categoria a ser atualizada.
  /// [name] Novo nome da categoria.
  /// [description] Nova descrição da categoria.
  /// Retorna sucesso ou erro.
  Future<ResultStatus<bool, String>> updateCategory({
    required int id,
    required String name,
    String? description,
  }) async {
    try {
      // Verificar se a categoria existe
      final exists = await _dao.getById(id);
      if (exists == null) {
        return ResultError('Categoria com ID $id não encontrada');
      }

      // Verificar se o novo nome já existe em outra categoria
      final nameExists = await _dao.getByName(name);
      if (nameExists != null && nameExists.id != id) {
        return ResultError('Já existe outra categoria com o nome "$name"');
      }

      final success = await _dao.updateCategory(
        id: id,
        name: name,
        description: description,
      );

      if (success) {
        return ResultSuccess(true);
      }
      return ResultError('Erro ao atualizar categoria');
    } on Exception catch (e) {
      return ResultError('Erro ao atualizar categoria: ${e.toString()}');
    }
  }
}
