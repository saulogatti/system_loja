import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/category.dart';

part 'category_state.freezed.dart';

/// Estados da tela de gerenciamento de categorias.
@freezed
sealed class CategoryState with _$CategoryState {
  /// Estado inicial
  const factory CategoryState.initial() = _Initial;

  /// Carregando dados
  const factory CategoryState.loading() = _Loading;

  /// Categorias carregadas com sucesso
  const factory CategoryState.loaded({
    required List<Category> categories,
  }) = _Loaded;

  /// Categoria criada com sucesso
  const factory CategoryState.created({
    required List<Category> categories,
  }) = _Created;

  /// Categoria atualizada com sucesso
  const factory CategoryState.updated({
    required List<Category> categories,
  }) = _Updated;

  /// Categoria removida com sucesso
  const factory CategoryState.deleted({
    required List<Category> categories,
  }) = _Deleted;

  /// Erro ao processar operação
  const factory CategoryState.error({
    required String message,
  }) = _Error;
}
