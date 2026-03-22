import 'package:drift/isolate.dart';
import 'package:sqlite3/common.dart';
import 'package:system_loja/core/interface/i_customer_repository.dart';
import 'package:system_loja/core/interface/i_log_repository.dart';
import 'package:system_loja/domain/repository/exceptions/customer_exception.dart';
import 'package:system_loja/aplication/system_error_manager.dart';
import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/database/dao/customer_dao.dart';

class CustomerRepository implements ICustomerRepository {
  final ILogRepository _logRepository;
  final CustomerDao _customerDao;

  CustomerRepository({
    required ILogRepository logRepository,
    required CustomerDao customerDao,
  }) : _logRepository = logRepository,
       _customerDao = customerDao;

  /// Deleta um cliente pelo ID.
  ///
  /// Retorna [ResultStatus] indicando sucesso ou erro com mensagem.
  @override
  Future<ResultStatus<bool, String>> deleteClient(int id) async {
    try {
      final customer = await _customerDao.getById(id);
      if (customer == null) {
        return ResultStatus.error('Cliente com ID $id não encontrado.');
      }

      await _customerDao.deleteCustomer(id);

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
  @override
  Future<ResultStatus<Map<int, Customer>, String>>
  fetchMappedCustomers() async {
    try {
      final data = await _customerDao.getAll();
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
  @override
  Future<ResultStatus<Customer?, String>> findCustomerById(int id) async {
    try {
      final data = await _customerDao.getById(id);
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
  @override
  Future<ResultStatus<Customer?, String>> findWith({
    required String cpf,
  }) async {
    try {
      final allCustomers = await _customerDao.getAll();
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
  @override
  Future<ResultStatus<List<Customer>, String>> getAllCustomers() async {
    try {
      final data = await _customerDao.getAll();
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
  @override
  Future<ResultStatus<bool, String>> saveCustomer(Customer customer) async {
    try {
      await _customerDao.addCustomer(customer);

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
      if (e is DriftRemoteException && e.remoteCause is SqliteException) {
        return ResultStatus.error(
          'Erro ao salvar cliente: ${(e.remoteCause as SqliteException).message.toString()}',
        );
      }
      return ResultStatus.error('Erro ao salvar cliente.');
    }
  }

  /// Atualiza um cliente existente.
  ///
  /// Retorna [ResultStatus] indicando sucesso ou erro com mensagem.
  @override
  Future<ResultStatus<bool, String>> updateCustomer(Customer customer) async {
    try {
      final exists = await _customerDao.getById(customer.id);
      if (exists == null) {
        return ResultStatus.error(
          'Cliente com ID ${customer.id} não encontrado.',
        );
      }

      await _customerDao.updateCustomer(customer);

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
      if (e is DriftRemoteException && e.remoteCause is SqliteException) {
        return ResultStatus.error(
          'Erro ao atualizar cliente: ${(e.remoteCause as SqliteException).message.toString()}',
        );
      }
      return ResultStatus.error('Erro ao atualizar cliente.');
    }
  }
}
