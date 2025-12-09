import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/produto.dart';

part 'sales_state.freezed.dart';

@freezed
@immutable
sealed class SalesState with _$SalesState {
  factory SalesState.error({required String message}) = SalesError;
  factory SalesState.initial() = SalesInitial;
  factory SalesState.loaded({required Map<int, Invoice> items}) =
      SalesLoaded;
  factory SalesState.loadedCustomers({required Map<int, Customer> customers}) =
      SalesLoadedCustomers;
  factory SalesState.loading() = SalesLoading;
  factory SalesState.saved({required Map<int, Invoice> items}) = SalesSaved;

  factory SalesState.loadingProducts() = SalesLoadingProducts;

  factory SalesState.loadedProducts({required List<Produto> products}) = SalesLoadedProducts;

  factory SalesState.loadProductsFailure({required String message}) = SalesLoadProductsFailure;
}
