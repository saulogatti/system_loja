import 'package:drift/drift.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';

@UseRowClass(SystemConfiguration)
class SystemRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get lastUpdatedDate => dateTime()();
  TextColumn get priceConfiguration => text().map(PriceConfiguration.converter)();
  DateTimeColumn get registrationDate => dateTime()();
  TextColumn get systemUserData => text().map(SystemUserData.converter)();
}
