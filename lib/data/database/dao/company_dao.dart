import 'package:drift/drift.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/extension/company_to_companion.dart';
import 'package:system_loja/data/database/mapper/drift_to_domain.dart';
import 'package:system_loja/data/database/table/company_records.dart';

part 'company_dao.g.dart';

/// DAO para gerenciar operações CRUD de empresas no banco de dados Drift.
///
/// Utiliza o padrão Repository e conversões entre Company (domínio) e
/// CompanyRecord (Drift) através de extensões.
@DriftAccessor(tables: [CompanyRecords])
class CompanyDao extends DatabaseAccessor<AppDatabase> with _$CompanyDaoMixin {
  CompanyDao(super.db);

  /// Insere uma nova empresa no banco de dados.
  ///
  /// Aceita um objeto Company do domínio e o converte para Companion.
  /// Retorna o ID gerado automaticamente.
  /// Lança exceção se o CNPJ já existir (constraint UNIQUE).
  Future<int> addCompany(Company company) => into(
      companyRecords,
    ).insert(company.toCompanion(), mode: InsertMode.insertOrAbort);

  /// Remove uma empresa do banco de dados pelo ID.
  ///
  /// Retorna o número de linhas afetadas (normalmente 1 ou 0).
  Future<int> deleteCompany(int id) => (delete(companyRecords)..where((t) => t.id.equals(id))).go();

  /// Retorna todas as empresas como objetos de domínio Company.
  Future<List<Company>> getAll() async {
    final records = await select(companyRecords).get();
    return records.map((e) => e.toDomain()).toList();
  }

  /// Busca uma empresa pelo ID.
  ///
  /// Retorna null se a empresa não for encontrada.
  Future<Company?> getById(int id) async {
    final record = await (select(
      companyRecords,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return record?.toDomain();
  }

  /// Busca uma empresa pelo CNPJ.
  ///
  /// Retorna null se a empresa não for encontrada.
  Future<Company?> getByCnpj(String cnpj) async {
    final record = await (select(
      companyRecords,
    )..where((t) => t.cnpj.equals(cnpj))).getSingleOrNull();
    return record?.toDomain();
  }

  /// Atualiza uma empresa existente no banco de dados.
  ///
  /// Retorna true se a atualização foi bem-sucedida, false caso contrário.
  Future<bool> updateCompany(Company company) => update(companyRecords).replace(company.toCompanion(forUpdate: true));
}
