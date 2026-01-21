import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/product.dart';

part 'product_state.freezed.dart';

@freezed
sealed class ProductState with _$ProductState {
  // Delete product success state
  factory ProductState.deleteSuccess({required List<Product> produtos}) =
      ProductStateDeleteSuccess;
  // Error state for operations
  factory ProductState.error({required String message}) = ProductStateError;
  // Find product by code failure state
  factory ProductState.findByCodeFailure({required String message}) =
      ProductStateFindByCodeFailure;
  // Find procuct by code state
  factory ProductState.findByCodeSuccess({required Product produto}) =
      ProductStateFindByCodeSuccess;
  // find product by id product state
  factory ProductState.findByIdSuccess({required Product produto}) =
      ProductStateFindByIdSuccess;
  factory ProductState.insertSuccess({required List<Product> produtos}) =
      ProductStateInsertSuccess;
  factory ProductState.loading() = ProductStateLoading;
  // Update product success state
  factory ProductState.updateSuccess({required List<Product> produtos}) =
      ProductStateUpdateSuccess;
}
