import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';
import 'package:system_loja/data/entry/person_entry.dart';
import 'package:system_loja/data/entry/system_user_data_entry.dart';

@UseRowClass(SystemConfiguration)
class SystemRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get lastUpdatedDate => dateTime()();
  TextColumn get priceConfiguration => text().map(PriceConfiguration.converter)();
  DateTimeColumn get registrationDate => dateTime()();
  TextColumn get systemUserData => text().map(SystemUserDataConverter())();
}

class SystemUserDataConverter extends TypeConverter<SystemUserData, String> {
  const SystemUserDataConverter();

  @override
  SystemUserData fromSql(String fromDb) => SystemUserDataEntry.fromJson(jsonDecode(fromDb));

  @override
  String toSql(SystemUserData value) => jsonEncode(
    SystemUserDataEntry(
      systemKey: value.systemKey,
      description: value.description,
      person: PersonEntry(
        name: value.person.name,
        email: value.person.email,
        phone: value.person.phone,
        document: value.person.document,
      ),
    ).toJson(),
  );
}
