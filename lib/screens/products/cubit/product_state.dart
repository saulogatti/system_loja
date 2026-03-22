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

  factory ProductState.insertSuccess({required List<Product> produtos}) =
      ProductStateInsertSuccess;
  factory ProductState.loading() = ProductStateLoading;
  factory ProductState.loaded({required List<Product> produtos}) =
      ProductStateLoaded;

  // Update product success state
  factory ProductState.updateSuccess({required List<Product> produtos}) =
      ProductStateUpdateSuccess;
}
