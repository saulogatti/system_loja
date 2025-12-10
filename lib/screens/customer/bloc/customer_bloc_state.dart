part of 'customer_bloc.dart';

@freezed
sealed class CustomerBlocState with _$CustomerBlocState {
  const factory CustomerBlocState.initial() = _Initial;
  
  const factory CustomerBlocState.loading() = _Loading;
  
  const factory CustomerBlocState.customersLoaded({
    required Map<int, Customer> customers, required EnumStateCustomerLoaded  stateType,
  }) = _CustomersLoaded;

  const factory CustomerBlocState.customerError({required String message}) =
      _CustomerError;
      const factory CustomerBlocState.customerFound({
    required Customer customer,
  }) = _CustomerFound;
  
}
/// Representa os diferentes contextos de carregamento de clientes.
/// Utilizado para indicar a ação realizada ou o motivo pelo qual os clientes foram carregados.
enum EnumStateCustomerLoaded {
  /// Indica que um cliente foi cadastrado.
  registerCustomer,

  /// Indica que um cliente foi excluído.
  deleteCustomer,

  /// Indica que a lista de clientes foi carregada.
  customersLoaded,

  /// Indica que um cliente foi atualizado.
  updateCustomer,
}