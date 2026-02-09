// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Address',
  json,
  ($checkedConvert) {
    final val = Address(
      street: $checkedConvert('street', (v) => v as String? ?? ''),
      zipCode: $checkedConvert('zipCode', (v) => v as String? ?? ''),
      neighborhood: $checkedConvert('neighborhood', (v) => v as String? ?? ''),
      city: $checkedConvert('city', (v) => v as String? ?? ''),
      state: $checkedConvert('state', (v) => v as String? ?? ''),
    );
    return val;
  },
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'street': instance.street,
  'zipCode': instance.zipCode,
  'neighborhood': instance.neighborhood,
  'city': instance.city,
  'state': instance.state,
};
