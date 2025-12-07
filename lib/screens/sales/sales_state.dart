import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/models/invoice.dart';

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
}
