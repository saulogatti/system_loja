import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/produto.dart';

part 'produto_state.freezed.dart';

@freezed
sealed class ProductState with _$ProductState {
  // Find product by code failure state
  factory ProductState.findByCodeFailure({required String message}) =
      ProductStateFindByCodeFailure;
  // Find procuct by code state
  factory ProductState.findByCodeSuccess({required Produto produto}) =
      ProductStateFindByCodeSuccess;
  // find product by id product state
  factory ProductState.findByIdSuccess({required Produto produto}) =
      ProductStateFindByIdSuccess;
  factory ProductState.insertSuccess({required List<Produto> produtos}) =
      ProductStateInsertSuccess;
  factory ProductState.newIdGenerated({required int newId}) =
      ProductStateNewIdGenerated;
}
