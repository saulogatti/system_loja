import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_category_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/screens/categories/cubit/category_state.dart';

/// Gerencia o estado da tela de categorias e operações CRUD.
///
/// Este Cubit coordena operações de criação, leitura, atualização
/// e exclusão de categorias através do CategoryRepository.
class CategoryCubit extends Cubit<CategoryState> {
  final ICategoryRepository _repository;

  CategoryCubit({required ICategoryRepository repository})
    : _repository = repository,
      super(const CategoryState.initial()) {
    loadCategories();
  }

  /// Cria uma nova categoria.
  ///
  /// [name] Nome da categoria (obrigatório).
  /// [description] Descrição opcional da categoria.
  Future<void> createCategory({required String name, String? description}) async {
    emit(const CategoryState.loading());

    final result = await _repository.createCategory(name: name, description: description);

    switch (result) {
      case ResultSuccess():
        final categoriesResult = await _repository.getAllCategories();
        switch (categoriesResult) {
          case ResultSuccess(result: final categories):
            emit(CategoryState.created(categories: categories));
          case ResultError(resultError: final error):
            emit(CategoryState.error(message: error));
        }
      case ResultError(resultError: final error):
        emit(CategoryState.error(message: error));
    }
  }

  /// Remove uma categoria.
  ///
  /// [id] Identificador da categoria a ser removida.
  Future<void> deleteCategory(int id) async {
    emit(const CategoryState.loading());

    final result = await _repository.deleteCategory(id);

    switch (result) {
      case ResultSuccess():
        final categoriesResult = await _repository.getAllCategories();
        switch (categoriesResult) {
          case ResultSuccess(result: final categories):
            emit(CategoryState.deleted(categories: categories));
          case ResultError(resultError: final error):
            emit(CategoryState.error(message: error));
        }
      case ResultError(resultError: final error):
        emit(CategoryState.error(message: error));
    }
  }

  /// Carrega todas as categorias do banco de dados.
  Future<void> loadCategories() async {
    emit(const CategoryState.loading());

    final result = await _repository.getAllCategories();
    switch (result) {
      case ResultSuccess(result: final categories):
        emit(CategoryState.loaded(categories: categories));
      case ResultError(resultError: final error):
        emit(CategoryState.error(message: error));
    }
  }

  /// Atualiza uma categoria existente.
  ///
  /// [id] Identificador da categoria.
  /// [name] Novo nome da categoria.
  /// [description] Nova descrição da categoria.
  Future<void> updateCategory({required int id, required String name, String? description}) async {
    emit(const CategoryState.loading());

    final result = await _repository.updateCategory(id: id, name: name, description: description);

    switch (result) {
      case ResultSuccess():
        final categoriesResult = await _repository.getAllCategories();
        switch (categoriesResult) {
          case ResultSuccess(result: final categories):
            emit(CategoryState.updated(categories: categories));
          case ResultError(resultError: final error):
            emit(CategoryState.error(message: error));
        }
      case ResultError(resultError: final error):
        emit(CategoryState.error(message: error));
    }
  }
}
