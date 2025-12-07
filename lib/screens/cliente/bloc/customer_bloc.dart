import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/repository/customer_repository.dart';

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
        CustomerBlocState.customersLoaded(customers: customers.values.toList()),
      );
    } catch (e) {
      emit(
        CustomerBlocState.customerError(
          message: 'Erro ao carregar clientes: ${e.toString()}',
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
      final customer = Customer(
        id: 0, // SQLite AUTOINCREMENT gera o ID automaticamente
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
        CustomerBlocState.customersLoaded(customers: customers.values.toList()),
      );
    } catch (e) {
      emit(
        CustomerBlocState.customerError(
          message: e.toString().contains('CPF já cadastrado')
              ? 'Erro: CPF já cadastrado!'
              : 'Erro ao cadastrar cliente: ${e.toString()}',
        ),
      );
    }
  }
}
