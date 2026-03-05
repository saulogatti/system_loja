import 'package:drift/drift.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';

@UseRowClass(SystemConfiguration)
class SystemRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get registrationDate => dateTime()();
  DateTimeColumn get lastUpdatedDate => dateTime()();
  TextColumn get priceConfiguration =>
      text().map(PriceConfiguration.converter)();

}
