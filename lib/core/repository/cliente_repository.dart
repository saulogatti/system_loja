import 'package:drift/drift.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/data/database/cliente_dao.dart';
import 'package:system_loja/data/database/extension/cliente_to_companion.dart';

class ClienteRepository {
  final ClienteDao dao;

  ClienteRepository(this.dao);

  Future<Customer?> buscarPorId(int id) async {
    final data = await dao.getById(id);
    return data?.toDomain();
  }

  Future<void> excluir(int id) async {
    await dao.deleteCliente(id);
  }

  Future<dynamic> findWith({required String cpf}) async {}
  Future<List<Customer>> listar() async {
    final data = await dao.getAll();
    return data.map((e) => e.toDomain()).toList();
  }

  Future<Map<int, Customer>> listarMapeado() async {
    final data = await dao.getAll();
    final customers = data.map((e) => e.toDomain()).toList();
    return {for (var customer in customers) customer.id: customer};
  }

  Future<void> salvar(Customer cliente) async {
    await dao.insertCliente(
      cliente.toCompanion().copyWith(id: Value(cliente.id)),
    );
  }
}
