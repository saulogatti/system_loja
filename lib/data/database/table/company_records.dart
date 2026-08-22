import 'package:drift/drift.dart';
import 'package:system_loja/data/converter/address_codec.dart';
import 'package:system_loja/data/database/app_database.dart';

/// Tabela Drift de empresas no [AppDatabase].
///
/// {@category persistencia}
/// {@subCategory Cadastros}
class CompanyRecords extends Table {
  TextColumn get address =>
      text().map(AddressCodec.driftConverter).nullable()();
  TextColumn get cnpj => text().unique()();
  TextColumn get name => text()();
  TextColumn get email => text().nullable()();
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
  DateTimeColumn get registrationDate =>
      dateTime().withDefault(currentDateAndTime)();
}
