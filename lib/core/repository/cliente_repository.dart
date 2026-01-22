import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/repository/system/log_repository.dart';
import 'package:system_loja/data/database/dao/cliente_dao.dart';

class ClienteRepository {
  LogRepository _logRepository = LogRepository();
  final ClienteDao dao;

  ClienteRepository(this.dao);

  Future<Customer?> buscarPorId(int id) async {
    final data = await dao.getById(id);
    return data;
  }

  Future<void> excluir(int id) async {
    _logRepository.createAndLogEntry(
      logActionType: .deletar,
      entityName: runtimeType.toString(),
      userId: 0,
      username: 'system',
      logDetails: 'Deleted customer with ID $id',
    );
    await dao.deleteCliente(id);
  }

  Future<Customer?> findWith({required String cpf}) async {
    final allCustomers = await dao.getAll();
    try {
      return allCustomers.firstWhere((customer) => customer.cpf == cpf);
    } catch (e) {
      return null;
    }
  }

  Future<List<Customer>> listar() async {
    final data = await dao.getAll();
    return data;
  }

  Future<Map<int, Customer>> listarMapeado() async {
    final data = await dao.getAll();
    final customers = data;
    return {for (var customer in customers) customer.id: customer};
  }

  Future<void> salvar(Customer cliente) async {
    await dao.insertCliente(cliente);
  }

  Future<void> update(Customer customer) async {
    await dao.updateCliente(customer);
  }
}
