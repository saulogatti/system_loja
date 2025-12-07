part of 'customer_bloc.dart';

@freezed
sealed class CustomerBlocEvent with _$CustomerBlocEvent {
  const factory CustomerBlocEvent.registerCustomer({
    required String name,
    required String cpf,
    required String email,
    required String phone,
    required String address,
  }) = _RegisterCustomer;
  
  const factory CustomerBlocEvent.loadCustomers() = _LoadCustomers;
}
