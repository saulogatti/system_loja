import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/interface/i_customer_repository.dart';
import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/screens/utils/string_extensions.dart';

part 'customer_bloc.freezed.dart';
part 'customer_bloc_event.dart';
part 'customer_bloc_state.dart';

// Neste arquivo não pode ter try/cacth ele apeans retorna erro para a tela que ja vem tratados. Remover try/catch desnecessários e usar ResultStatus
/// BLoC para gerenciamento de estado de clientes
///
/// Utiliza o ClienteSqlManager para operações de banco de dados
/// e implementa o padrão BLoC para separação de lógica de negócio da UI.
class CustomerBloc extends Bloc<CustomerBlocEvent, CustomerBlocState> {
  final ICustomerRepository _customerRepository;
  CustomerBloc(this._customerRepository) : super(const _Initial()) {
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
    final result = await _customerRepository.deleteClient(event.id);
    // Use switch por que sao sealed classes
    switch (result) {
      case ResultSuccess(:final result):
        if (result) {
          // Recarrega a lista de clientes após deletar
          final customers = await _customerRepository.fetchMappedCustomers();
          if (customers is ResultSuccess) {
            emit(
              CustomerBlocState.customersLoaded(
                customers: customers.asSuccess,
                stateType: EnumStateCustomerLoaded.deleteCustomer,
              ),
            );
          } else if (customers is ResultError) {
            emit(
              CustomerBlocState.customerError(
                message:
                    'Erro ao carregar clientes após deleção: ${customers.asError}',
              ),
            );
          }
        }
      case ResultError<bool, String>(:final resultError):
        emit(
          CustomerBlocState.customerError(
            message: 'Erro ao deletar cliente: $resultError',
          ),
        );
    }
  }

  FutureOr<void> _onFindCustomerByCpf(
    _FindCustomerByCpf event,
    Emitter<CustomerBlocState> emit,
  ) async {
    emit(const CustomerBlocState.loading());
    final result = await _customerRepository.findWith(cpf: event.cpf);
    result.when(
      onSuccess: (customer) {
        if (customer == null) {
          emit(
            CustomerBlocState.customerError(
              message: 'Cliente com CPF ${event.cpf} não encontrado.',
            ),
          );
          return;
        }
        emit(CustomerBlocState.customerFound(customer: customer));
      },
      onError: (error) {
        emit(
          CustomerBlocState.customerError(
            message: 'Erro ao buscar cliente: $error',
          ),
        );
      },
    );
  }

  /// Carrega todos os clientes do banco de dados
  Future<void> _onLoadCustomers(
    _LoadCustomers event,
    Emitter<CustomerBlocState> emit,
  ) async {
    emit(const CustomerBlocState.loading());
    final result = await _customerRepository.fetchMappedCustomers();
    result.when(
      onSuccess: (customers) {
        emit(
          CustomerBlocState.customersLoaded(
            customers: customers,
            stateType: EnumStateCustomerLoaded.customersLoaded,
          ),
        );
      },
      onError: (error) {
        emit(
          CustomerBlocState.customerError(
            message: 'Erro ao carregar clientes: $error',
          ),
        );
      },
    );
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
    if (event.email.isNotEmpty && !event.email.isValidEmail()) {
      emit(
        const CustomerBlocState.customerError(message: 'Erro: Email inválido!'),
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

    final result = await _customerRepository.saveCustomer(
      Customer(
        id: 0,
        name: event.name,
        cpf: event.cpf,
        email: event.email,
        phone: event.phone,
        address: Address(
          street: event.street,
          zipCode: event.zipCode,
          neighborhood: event.neighborhood,
          city: event.city,
          state: event.state,
        ),
        registrationDate: DateTime.now(),
        lastUpdatedDate: DateTime.now(),
      ),
    );
    if (result.isSuccessful) {
      final customers = await _customerRepository.fetchMappedCustomers();
      switch (customers) {
        case ResultSuccess(:final result):
          emit(
            CustomerBlocState.customersLoaded(
              customers: result,
              stateType: EnumStateCustomerLoaded.registerCustomer,
            ),
          );
        case ResultError<Map<int, Customer>, String>(:final resultError):
          emit(CustomerBlocState.customerError(message: resultError));
      }
    } else {
      emit(CustomerBlocState.customerError(message: result.asError));
    }
  }

  /// Atualiza um cliente existente no banco de dados
  FutureOr<void> _onUpdateCustomer(
    _UpdateCustomer event,
    Emitter<CustomerBlocState> emit,
  ) async {
    emit(const CustomerBlocState.loading());

    final resultUpdate = await _customerRepository.updateCustomer(
      event.customer,
    );
    switch (resultUpdate) {
      case ResultSuccess(:final result):
        if (!result) {
          emit(
            CustomerBlocState.customerError(
              message: 'Erro ao atualizar cliente: Cliente não encontrado.',
            ),
          );
          return;
        }

        // Recarrega a lista de clientes após atualizar
        final resultFetch = await _customerRepository.fetchMappedCustomers();
        switch (resultFetch) {
          case ResultSuccess(:final result):
            emit(
              CustomerBlocState.customersLoaded(
                customers: result,
                stateType: EnumStateCustomerLoaded.updateCustomer,
              ),
            );
          case ResultError(:final resultError):
            emit(
              CustomerBlocState.customerError(
                message:
                    'Erro ao carregar clientes após atualização: $resultError',
              ),
            );
        }

      case ResultError<bool, String>(:final resultError):
        emit(
          CustomerBlocState.customerError(
            message: 'Erro ao atualizar cliente: $resultError',
          ),
        );
        return;
    }
  }
}
