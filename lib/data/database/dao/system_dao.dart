import 'package:drift/drift.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/data/database/system_database.dart';
import 'package:system_loja/data/database/table/system/system_records.dart';

part 'system_dao.g.dart';

@DriftAccessor(tables: [SystemRecords])
class SystemDao extends DatabaseAccessor<SystemDatabase> with _$SystemDaoMixin {
  SystemDao(super.db);

  Future<SystemConfiguration?> getSystemConfiguration() {
    return (select(systemRecords)..limit(1)).getSingleOrNull();
  }

  Future<void> saveSystemConfiguration(SystemConfiguration data) async {
    final existingConfig = await getSystemConfiguration();
    if (existingConfig == null) {
      await into(systemRecords).insert(
        SystemRecordsCompanion(
          priceConfiguration: Value(data.priceConfiguration),
          registrationDate: Value(data.registrationDate),
          lastUpdatedDate: Value(data.lastUpdatedDate),
        ),
      );
    } else {
      await update(systemRecords).replace(
        SystemRecordsCompanion(
          id: Value(existingConfig.id),
          priceConfiguration: Value(data.priceConfiguration),
        ),
      );
    }
  }
}
