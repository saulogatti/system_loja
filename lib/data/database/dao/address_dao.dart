import 'package:drift/drift.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/table/address_records.dart';

part 'address_dao.g.dart';

@DriftAccessor(tables: [AddressRecords])
class AddressDao extends DatabaseAccessor<AppDatabase> with _$AddressDaoMixin {
  AddressDao(super.db);
}