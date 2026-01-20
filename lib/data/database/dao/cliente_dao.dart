import 'package:drift/drift.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/extension/cliente_to_companion.dart';
import 'package:system_loja/data/database/table/clientes_records.dart';

part 'cliente_dao.g.dart';

/// DAO para gerenciar operações CRUD de clientes no banco de dados Drift.
///
/// Utiliza o padrão Repository e conversões entre Customer (domínio) e
/// ClientesRecord (Drift) através de extensões.
@DriftAccessor(tables: [ClientesRecords])
class ClienteDao extends DatabaseAccessor<AppDatabase> with _$ClienteDaoMixin {
  ClienteDao(super.db);

  /// Remove um cliente do banco de dados pelo ID.
  ///
  /// Retorna o número de linhas afetadas (normalmente 1 ou 0).
  Future<int> deleteCliente(int id) {
    return (delete(clientesRecords)..where((t) => t.id.equals(id))).go();
  }

  /// Retorna todos os clientes como objetos de domínio Customer.
  Future<List<Customer>> getAll() async {
    final records = await select(clientesRecords).get();
    return records.map((record) => record.toDomain()).toList();
  }

  /// Busca um cliente pelo ID.
  ///
  /// Retorna null se o cliente não for encontrado.
  Future<Customer?> getById(int id) async {
    final record = await (select(
      clientesRecords,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return record?.toDomain();
  }

  /// Insere um novo cliente no banco de dados.
  ///
  /// Aceita um objeto Customer do domínio e o converte para Companion.
  /// Retorna o ID gerado automaticamente.
  Future<int> insertCliente(Customer customer) {
    return into(
      clientesRecords,
    ).insert(customer.toCompanion(), mode: InsertMode.insertOrReplace);
  }

  /// Atualiza um cliente existente no banco de dados.
  ///
  /// Retorna true se a atualização foi bem-sucedida, false caso contrário.
  Future<bool> updateCliente(Customer customer) {
    return update(
      clientesRecords,
    ).replace(customer.toCompanion(forUpdate: true));
  }
}
