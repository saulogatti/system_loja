import 'package:drift/remote.dart';
import 'package:system_loja/core/managers/exceptions/customer_exception.dart';
import 'package:system_loja/core/managers/system_error_manager.dart';
import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/repository/system/log_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/database/dao/customer_dao.dart';
import 'package:system_loja/screens/injection/app_injection.dart';

class CustomerRepository {
  final LogRepository _logRepository = LogRepository();
  final CustomerDao dao = AppInjection.instance.appDatabase.customerDao;

  CustomerRepository();

  /// Deleta um cliente pelo ID.
  ///
  /// Retorna [ResultStatus] indicando sucesso ou erro com mensagem.
  Future<ResultStatus<bool, String>> deleteClient(int id) async {
    try {
      final customer = await dao.getById(id);
      if (customer == null) {
        return ResultStatus.error('Cliente com ID $id não encontrado.');
      }

      await dao.deleteCustomer(id);

      await _logRepository.createAndLogEntry(
        logActionType: ActionType.deletar,
        entityName: runtimeType.toString(),
        userId: 0,
        username: 'system',
        logDetails: 'Deleted customer with ID $id',
      );

      return ResultStatus.success(true);
    } on CustomerException catch (e) {
      await reportError(e, StackTrace.current);
      return ResultStatus.error(e.message);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultStatus.error('Erro ao deletar cliente.');
    }
  }

  /// Busca todos os clientes mapeados por ID.
  ///
  /// Retorna [ResultStatus] com Map de clientes ou mensagem de erro.
  Future<ResultStatus<Map<int, Customer>, String>>
  fetchMappedCustomers() async {
    try {
      final data = await dao.getAll();
      final customers = data;
      final mappedCustomers = {
        for (var customer in customers) customer.id: customer,
      };
      return ResultStatus.success(mappedCustomers);
    } on CustomerException catch (e) {
      await reportError(e, StackTrace.current);
      return ResultStatus.error(e.message);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultStatus.error('Erro ao buscar clientes mapeados.');
    }
  }

  /// Busca um cliente específico pelo ID.
  ///
  /// Retorna [ResultStatus] com o cliente encontrado ou mensagem de erro.
  Future<ResultStatus<Customer?, String>> findCustomerById(int id) async {
    try {
      final data = await dao.getById(id);
      return ResultStatus.success(data);
    } on CustomerException catch (e) {
      await reportError(e, StackTrace.current);
      return ResultStatus.error(e.message);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultStatus.error('Erro ao buscar cliente por ID.');
    }
  }

  /// Busca um cliente pelo CPF.
  ///
  /// Retorna [ResultStatus] com o cliente encontrado ou mensagem de erro.
  Future<ResultStatus<Customer?, String>> findWith({
    required String cpf,
  }) async {
    try {
      final allCustomers = await dao.getAll();
      try {
        final customer = allCustomers.firstWhere(
          (customer) => customer.cpf == cpf,
        );
        return ResultStatus.success(customer);
      } on StateError {
        // Cliente não encontrado
        return ResultStatus.success(null);
      }
    } on CustomerException catch (e) {
      await reportError(e, StackTrace.current);
      return ResultStatus.error(e.message);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultStatus.error('Erro ao buscar cliente por CPF.');
    }
  }

  /// Obtém todos os clientes.
  ///
  /// Retorna [ResultStatus] com lista de clientes ou mensagem de erro.
  Future<ResultStatus<List<Customer>, String>> getAllCustomers() async {
    try {
      final data = await dao.getAll();
      return ResultStatus.success(data);
    } on CustomerException catch (e) {
      await reportError(e, StackTrace.current);
      return ResultStatus.error(e.message);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      if (e is DriftRemoteException) {
        return ResultStatus.error(
          'Erro ao buscar todos os clientes: ${e.remoteCause.toString()}',
        );
      }
      return ResultStatus.error('Erro ao buscar todos os clientes.');
    }
  }

  /// Salva um novo cliente.
  ///
  /// Retorna [ResultStatus] indicando sucesso ou erro com mensagem.
  Future<ResultStatus<bool, String>> saveCustomer(Customer customer) async {
    try {
      await dao.addCustomer(customer);

      await _logRepository.createAndLogEntry(
        logActionType: ActionType.criar,
        entityName: runtimeType.toString(),
        userId: 0,
        username: 'system',
        logDetails: 'Cliente ${customer.name} (ID: ${customer.id}) criado.',
      );

      return ResultStatus.success(true);
    } on CustomerException catch (e) {
      await reportError(e, StackTrace.current);
      return ResultStatus.error(e.message);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      if (e is DriftRemoteException) {
        return ResultStatus.error(
          'Erro ao salvar cliente: ${e.remoteCause.toString()}',
        );
      }
      return ResultStatus.error('Erro ao salvar cliente.');
    }
  }

  /// Atualiza um cliente existente.
  ///
  /// Retorna [ResultStatus] indicando sucesso ou erro com mensagem.
  Future<ResultStatus<bool, String>> updateCustomer(Customer customer) async {
    try {
      final exists = await dao.getById(customer.id);
      if (exists == null) {
        return ResultStatus.error(
          'Cliente com ID ${customer.id} não encontrado.',
        );
      }

      await dao.updateCustomer(customer);

      await _logRepository.createAndLogEntry(
        logActionType: ActionType.atualizar,
        entityName: runtimeType.toString(),
        userId: 0,
        username: 'system',
        logDetails: 'Cliente ${customer.name} (ID: ${customer.id}) atualizado.',
      );

      return ResultStatus.success(true);
    } on CustomerException catch (e) {
      await reportError(e, StackTrace.current);
      return ResultStatus.error(e.message);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      if (e is DriftRemoteException) {
        return ResultStatus.error(
          'Erro ao atualizar cliente: ${e.remoteCause.toString()}',
        );
      }
      return ResultStatus.error('Erro ao atualizar cliente.');
    }
  }
}
