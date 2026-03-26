import 'package:drift/drift.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/data/database/system_database.dart';
import 'package:system_loja/data/database/table/system/system_records.dart';
import 'package:system_loja/data/entry/system_configuration_entry.dart';
import 'package:system_loja/data/entry/system_user_data_entry.dart';

part 'system_dao.g.dart';

@DriftAccessor(tables: [SystemRecords])
class SystemDao extends DatabaseAccessor<SystemDatabase> with _$SystemDaoMixin {
  SystemDao(super.db);

  Future<SystemConfiguration?> getSystemConfiguration() async {
    final row = await _getLatestConfiguration();
    return row?.toDomain();
  }

  Future<void> saveSystemConfiguration(SystemConfiguration data) async {
    await transaction(() async {
      final latestConfiguration = await _getLatestConfiguration();

      if (latestConfiguration == null) {
        await into(systemRecords).insert(
          SystemRecordsCompanion.insert(
            priceConfiguration: data.priceConfiguration,
            registrationDate: data.registrationDate,
            lastUpdatedDate: data.lastUpdatedDate,
            systemUserData: SystemUserDataEntry.fromSystemUserData(data.systemUserData),
          ),
        );
        return;
      }

      await (update(systemRecords)..where((table) => table.id.equals(latestConfiguration.id))).write(
        SystemRecordsCompanion(
          priceConfiguration: Value(data.priceConfiguration),
          registrationDate: Value(latestConfiguration.registrationDate),
          lastUpdatedDate: Value(data.lastUpdatedDate),
        ),
      );

      await (delete(systemRecords)..where((table) => table.id.isNotValue(latestConfiguration.id))).go();
    });
  }

  Future<SystemConfigurationEntry?> _getLatestConfiguration() {
    return (select(systemRecords)
          ..orderBy([(table) => OrderingTerm.desc(table.id)])
          ..limit(1))
        .getSingleOrNull();
  }
}
