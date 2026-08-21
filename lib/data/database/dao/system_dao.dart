import 'package:drift/drift.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/data/database/system_database.dart';
import 'package:system_loja/data/database/table/system/system_records.dart';
import 'package:system_loja/data/entry/system_configuration_entry.dart';
import 'package:system_loja/data/entry/system_user_data_entry.dart';

part 'system_dao.g.dart';

/// DAO Drift de configuração do sistema no [SystemDatabase].
///
/// {@category persistencia}
/// {@subCategory Sistema}
///
/// Lê e grava [SystemConfiguration] em [SystemRecords]. Persistência
/// principal é Drift; JSON só entra como DTO da linha.
@DriftAccessor(tables: [SystemRecords])
class SystemDao extends DatabaseAccessor<SystemDatabase> with _$SystemDaoMixin {
  SystemDao(super.db);

  /// Retorna a configuração mais recente, ou null se a tabela estiver vazia.
  Future<SystemConfiguration?> getSystemConfiguration() async {
    final row = await _getLatestConfiguration();
    return row?.toDomain();
  }

  /// Remove a configuração mais recente, se existir.
  Future<void> deleteSystemConfiguration() async {
    await transaction(() async {
      final latestConfiguration = await _getLatestConfiguration();
      if (latestConfiguration != null) {
        await (delete(systemRecords)
              ..where((table) => table.id.equals(latestConfiguration.id)))
            .go();
      }
    });
  }

  /// Insere ou atualiza a configuração vigente e remove linhas extras.
  Future<void> saveSystemConfiguration(SystemConfiguration data) async {
    await transaction(() async {
      final latestConfiguration = await _getLatestConfiguration();

      if (latestConfiguration == null) {
        await into(systemRecords).insert(
          SystemRecordsCompanion.insert(
            priceConfiguration: data.priceConfiguration,
            registrationDate: data.registrationDate,
            lastUpdatedDate: data.lastUpdatedDate,
            systemUserData: SystemUserDataEntry.fromSystemUserData(
              data.systemUserData,
            ),
          ),
        );
        return;
      }

      await (update(
        systemRecords,
      )..where((table) => table.id.equals(latestConfiguration.id))).write(
        SystemRecordsCompanion(
          priceConfiguration: Value(data.priceConfiguration),
          registrationDate: Value(latestConfiguration.registrationDate),
          lastUpdatedDate: Value(data.lastUpdatedDate),
        ),
      );

      await (delete(
        systemRecords,
      )..where((table) => table.id.isNotValue(latestConfiguration.id))).go();
    });
  }

  Future<SystemConfigurationEntry?> _getLatestConfiguration() => (select(systemRecords)
          ..orderBy([(table) => OrderingTerm.desc(table.id)])
          ..limit(1))
        .getSingleOrNull();
}
