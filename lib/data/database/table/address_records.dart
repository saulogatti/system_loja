import 'package:drift/drift.dart';
import 'package:system_loja/data/database/app_database.dart';

/// Tabela Drift de endereços no [AppDatabase].
///
/// {@category persistencia}
/// {@subCategory Cadastros}
class AddressRecords extends Table {
  TextColumn get city => text()();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
  TextColumn get neighborhood => text()();

  TextColumn get state => text()();
  TextColumn get street => text()();
  TextColumn get zipCode => text()();
}
