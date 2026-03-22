import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:system_loja/data/converter/price_configuration_codec.dart';
import 'package:system_loja/data/entry/system_configuration_entry.dart';
import 'package:system_loja/data/entry/system_user_data_entry.dart';

@UseRowClass(SystemConfigurationEntry)
class SystemRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get lastUpdatedDate => dateTime()();
  TextColumn get priceConfiguration =>
      text().map(PriceConfigurationCodec.driftConverter)();
  DateTimeColumn get registrationDate => dateTime()();
  TextColumn get systemUserData => text().map(SystemUserDataConverter())();
}

class SystemUserDataConverter
    extends TypeConverter<SystemUserDataEntry, String> {
  const SystemUserDataConverter();

  @override
  SystemUserDataEntry fromSql(String fromDb) =>
      SystemUserDataEntry.fromJson(jsonDecode(fromDb));

  @override
  String toSql(SystemUserDataEntry value) => jsonEncode(value.toJson());
}
