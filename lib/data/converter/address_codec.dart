import 'package:drift/drift.dart' as drift;
import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/data/models/address_data.dart';

/// Conversão JSON ↔ [Address] e conversor Drift para colunas texto.
class AddressCodec {
  AddressCodec._();

  static drift.JsonTypeConverter2<Address, String, Object?> get driftConverter => drift.TypeConverter.json2(
    fromJson: (json) => AddressData.fromJson(json as Map<String, dynamic>).toDomain(),
    toJson: (address) => AddressData.fromDomain(address).toJson(),
  );
}
