import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/managers/exceptions/customer_exception.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/repository/customer_repository.dart';
import 'package:system_loja/core/utils/string_extensions.dart';

part 'customer_bloc.freezed.dart';
part 'customer_bloc_event.dart';
part 'customer_bloc_state.dart';

/// BLoC para gerenciamento de estado de clientes
///
/// Utiliza o ClienteSqlManager para operações de banco de dados
/// e implementa o padrão BLoC para separação de lógica de negócio da UI.
class CustomerBloc extends Bloc<CustomerBlocEvent, CustomerBlocState> {
  final CustomerRepository _customerRepository;

  CustomerBloc()
    : _customerRepository = CustomerRepository(),
      super(const _Initial()) {
    on<_LoadCustomers>(_onLoadCustomers);
    on<_RegisterCustomer>(_onRegisterCustomer);
    on<_DeleteCustomer>(_onDeleteCustomer);
    on<_FindCustomerByCpf>(_onFindCustomerByCpf);
    on<_UpdateCustomer>(_onUpdateCustomer);
  }

  FutureOr<void> _onDeleteCustomer(
    _DeleteCustomer event,
    Emitter<CustomerBlocState> emit,
  ) async {
    emit(const CustomerBlocState.loading());
    try {
      await _customerRepository.deleteWithId(event.id);
      // Recarrega a lista de clientes após deletar
      final customers = await _customerRepository.loadAll();
      emit(
        CustomerBlocState.customersLoaded(
          customers: customers,
          stateType: EnumStateCustomerLoaded.deleteCustomer,
        ),
      );
    } on CustomerException catch (e) {
      emit(
        CustomerBlocState.customerError(
          message: 'Erro ao deletar cliente: ${e.message}',
        ),
      );
    } catch (e) {
      emit(
        CustomerBlocState.customerError(
          message: 'Erro inesperado ao deletar cliente: $e',
        ),
      );
    }
  }

  FutureOr<void> _onFindCustomerByCpf(
    _FindCustomerByCpf event,
    Emitter<CustomerBlocState> emit,
  ) async {
    emit(const CustomerBlocState.loading());
    try {
      final customer = await _customerRepository.findWith(cpf: event.cpf);
      if (customer != null) {
        emit(CustomerBlocState.customerFound(customer: customer));
      } else {
        emit(
          const CustomerBlocState.customerError(
            message: 'Cliente não encontrado para o CPF informado.',
          ),
        );
      }
    } on CustomerException catch (e) {
      emit(
        CustomerBlocState.customerError(
          message: 'Erro ao buscar cliente: ${e.message}',
        ),
      );
    }
  }

  /// Carrega todos os clientes do banco de dados
  Future<void> _onLoadCustomers(
    _LoadCustomers event,
    Emitter<CustomerBlocState> emit,
  ) async {
    emit(const CustomerBlocState.loading());
    try {
      final customers = await _customerRepository.loadAll();
      emit(
        CustomerBlocState.customersLoaded(
          customers: customers,
          stateType: EnumStateCustomerLoaded.customersLoaded,
        ),
      );
    } on CustomerException catch (e) {
      emit(
        CustomerBlocState.customerError(
          message: 'Erro ao carregar clientes: ${e.message}',
        ),
      );
    }
  }

  /// Registra um novo cliente no banco de dados
  ///
  /// O ID é definido como 0 pois a tabela usa AUTOINCREMENT.
  /// O banco de dados SQLite gerará automaticamente o próximo ID disponível.
  Future<void> _onRegisterCustomer(
    _RegisterCustomer event,
    Emitter<CustomerBlocState> emit,
  ) async {
    emit(const CustomerBlocState.loading());

    try {
      if (event.cpf.isEmpty || !event.cpf.isValidCPF()) {
        emit(
          const CustomerBlocState.customerError(message: 'Erro: CPF inválido!'),
        );
        return;
      } else if (event.email.isNotEmpty && !event.email.isValidEmail()) {
        emit(
          const CustomerBlocState.customerError(
            message: 'Erro: Email inválido!',
          ),
        );
        return;
      } else if (event.phone.isNotEmpty && !event.phone.isValidPhone()) {
        emit(
          const CustomerBlocState.customerError(
            message: 'Erro: Telefone inválido!',
          ),
        );
        return;
      }

      final int newId = await _customerRepository.obtainNextId();
      final customer = Customer(
        id: newId,
        name: event.name,
        cpf: event.cpf,
        email: event.email,
        phone: event.phone,
        address: event.address,
      );

      await _customerRepository.saveNewCustomer(customer);

      // Recarrega a lista de clientes após adicionar
      final customers = await _customerRepository.loadAll();
      emit(
        CustomerBlocState.customersLoaded(
          customers: customers,
          stateType: EnumStateCustomerLoaded.registerCustomer,
        ),
      );
    } on CustomerException catch (e) {
      emit(
        CustomerBlocState.customerError(
          message: 'Erro ao cadastrar cliente: ${e.message}',
        ),
      );
    } catch (e) {
      emit(
        CustomerBlocState.customerError(
          message: 'Erro inesperado ao cadastrar cliente: $e',
        ),
      );
    }
  }

  /// Atualiza um cliente existente no banco de dados
  FutureOr<void> _onUpdateCustomer(
    _UpdateCustomer event,
    Emitter<CustomerBlocState> emit,
  ) async {
    emit(const CustomerBlocState.loading());
    try {
      await _customerRepository.updateCustomer(event.customer);
      // Recarrega a lista de clientes após atualizar
      final customers = await _customerRepository.loadAll();
      emit(
        CustomerBlocState.customersLoaded(
          customers: customers,
          stateType: EnumStateCustomerLoaded.updateCustomer,
        ),
      );
    } on CustomerException catch (e) {
      emit(
        CustomerBlocState.customerError(
          message: 'Erro ao atualizar cliente: ${e.message}',
        ),
      );
    }
  }
}
