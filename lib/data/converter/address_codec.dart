import 'package:drift/drift.dart' as drift;
import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/data/models/address_data.dart';

/// Codec JSON ↔ [Address] e conversor Drift de coluna texto.
///
/// {@category dados}
/// {@subCategory Cadastros}
///
/// JSON é só DTO/coluna serializada; o endereço de cadastro vive no Drift.
class AddressCodec {
  AddressCodec._();

  /// Conversor Drift (coluna texto ↔ [Address] via [AddressData]).
  static drift.JsonTypeConverter2<Address, String, Object?>
  get driftConverter => drift.TypeConverter.json2(
    fromJson: (json) =>
        AddressData.fromJson(json! as Map<String, dynamic>).toDomain(),
    toJson: (address) => AddressData.fromDomain(address).toJson(),
  );
}
