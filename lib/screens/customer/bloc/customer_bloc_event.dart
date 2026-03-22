part of 'customer_bloc.dart';

@freezed
sealed class CustomerBlocEvent with _$CustomerBlocEvent {
  const factory CustomerBlocEvent.registerCustomer({
    required String name,
    required String cpf,
    required String email,
    required String phone,
    required String street,
    required String zipCode,
    required String neighborhood,
    required String city,
    required String state,
  }) = _RegisterCustomer;

  const factory CustomerBlocEvent.loadCustomers() = _LoadCustomers;
  const factory CustomerBlocEvent.deleteCustomer({required int id}) =
      _DeleteCustomer;
  const factory CustomerBlocEvent.findCustomerByCpf({required String cpf}) =
      _FindCustomerByCpf;
  const factory CustomerBlocEvent.updateCustomer({required Customer customer}) =
      _UpdateCustomer;
}
