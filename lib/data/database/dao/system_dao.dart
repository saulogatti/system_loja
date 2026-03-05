import 'package:drift/drift.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/data/database/system_database.dart';
import 'package:system_loja/data/database/table/system/system_records.dart';

part 'system_dao.g.dart';

@DriftAccessor(tables: [SystemRecords])
class SystemDao extends DatabaseAccessor<SystemDatabase> with _$SystemDaoMixin {
  SystemDao(super.db);

  Future<SystemConfiguration?> getSystemConfiguration() {
    return _getLatestConfiguration();
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
            systemUserData: data.systemUserData,
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

  Future<SystemConfiguration?> _getLatestConfiguration() {
    return (select(systemRecords)
          ..orderBy([(table) => OrderingTerm.desc(table.id)])
          ..limit(1))
        .getSingleOrNull();
  }
}
