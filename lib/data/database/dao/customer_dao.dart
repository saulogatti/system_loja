import 'package:drift/drift.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/extension/customer_to_companion.dart';
import 'package:system_loja/data/database/mapper/drift_to_domain.dart';
import 'package:system_loja/data/database/table/customer_records.dart';

part 'customer_dao.g.dart';

/// DAO para gerenciar operações CRUD de clientes no banco de dados Drift.
///
/// Utiliza o padrão Repository e conversões entre Customer (domínio) e
/// CustomerRecord (Drift) através de extensões.
@DriftAccessor(tables: [CustomerRecords])
class CustomerDao extends DatabaseAccessor<AppDatabase>
    with _$CustomerDaoMixin {
  CustomerDao(super.attachedDatabase);

  /// Insere um novo cliente no banco de dados.
  ///
  /// Aceita um objeto Customer do domínio e o converte para Companion.
  /// Retorna o ID gerado automaticamente.
  Future<int> addCustomer(Customer customer) => into(
      customerRecords,
    ).insert(customer.toCompanion(), mode: InsertMode.insertOrAbort);

  /// Remove um cliente do banco de dados pelo ID.
  ///
  /// Retorna o número de linhas afetadas (normalmente 1 ou 0).
  Future<int> deleteCustomer(int id) => (delete(customerRecords)..where((t) => t.id.equals(id))).go();

  /// Retorna todos os clientes como objetos de domínio Customer.
  Future<List<Customer>> getAll() async {
    final records = await select(customerRecords).get();
    return records.map((e) => e.toDomain()).toList();
  }

  /// Busca um cliente pelo ID.
  ///
  /// Retorna null se o cliente não for encontrado.
  Future<Customer?> getById(int id) async {
    final record = await (select(
      customerRecords,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return record?.toDomain();
  }

  /// Busca um cliente pelo CPF.
  ///
  /// Retorna null se o cliente não for encontrado.
  Future<Customer?> getByCpf(String cpf) async {
    final record = await (select(
      customerRecords,
    )..where((t) => t.cpf.equals(cpf))).getSingleOrNull();
    return record?.toDomain();
  }

  /// Atualiza um cliente existente no banco de dados.
  ///
  /// Retorna true se a atualização foi bem-sucedida, false caso contrário.
  Future<bool> updateCustomer(Customer customer) => update(
      customerRecords,
    ).replace(customer.toCompanion(forUpdate: true));
}
