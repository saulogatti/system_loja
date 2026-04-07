import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';

part 'sales_state.freezed.dart';

@freezed
@immutable
sealed class SalesState with _$SalesState {
  factory SalesState.error({required String message}) = SalesError;
  factory SalesState.initial() = SalesInitial;
  factory SalesState.loaded({required Map<int, Invoice> items}) = SalesLoaded;
  factory SalesState.loadedAll({
    required List<Product> products,
    required List<PaymentMethodType> paymentMethods,
    required Map<int, Customer> customers,
    required Map<int, Company> companies,
    required Map<int, Invoice> invoices,
  }) = SalesLoadedAll;
  factory SalesState.loadedCustomers({required Map<int, Customer> customers}) =
      SalesLoadedCustomers;
  factory SalesState.loading() = SalesLoading;

  factory SalesState.loadingProducts() = SalesLoadingProducts;

  factory SalesState.loadProductsFailure({required String message}) =
      SalesLoadProductsFailure;

  factory SalesState.saved({required Map<int, Invoice> items}) = SalesSaved;
}
