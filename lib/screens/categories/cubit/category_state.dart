import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/category.dart';

part 'category_state.freezed.dart';

/// Estados da tela de gerenciamento de categorias.
@freezed
sealed class CategoryState with _$CategoryState {
  /// Categoria criada com sucesso
  const factory CategoryState.created({required List<Category> categories}) =
      CategoryCreated;

  const factory CategoryState.deleted({required List<Category> categories}) =
      CategoryDeleted;

  /// Erro ao carregar ou manipular categorias
  const factory CategoryState.error({required String message}) = CategoryError;

  /// Estado inicial
  const factory CategoryState.initial() = CategoryInitial;

  /// Categorias carregadas com sucesso
  const factory CategoryState.loaded({required List<Category> categories}) =
      CategoryLoaded;

  /// Carregando dados
  const factory CategoryState.loading() = CategoryLoading;

  /// Categoria atualizada com sucesso
  const factory CategoryState.updated({required List<Category> categories}) =
      CategoryUpdated;
}
