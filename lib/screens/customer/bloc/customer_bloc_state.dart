part of 'customer_bloc.dart';

@freezed
class CustomerBlocState with _$CustomerBlocState {
  const factory CustomerBlocState.initial() = _Initial;
  
  const factory CustomerBlocState.loading() = _Loading;
  
  const factory CustomerBlocState.customersLoaded({
    required Map<int, Customer> customers,
  }) = _CustomersLoaded;

  const factory CustomerBlocState.customerError({required String message}) =
      _CustomerError;
      const factory CustomerBlocState.customerFound({
    required Customer customer,
  }) = _CustomerFound;
  
}
