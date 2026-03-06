// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  street: json['street'] as String? ?? '',
  zipCode: json['zipCode'] as String? ?? '',
  neighborhood: json['neighborhood'] as String? ?? '',
  city: json['city'] as String? ?? '',
  state: json['state'] as String? ?? '',
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'street': instance.street,
  'zipCode': instance.zipCode,
  'neighborhood': instance.neighborhood,
  'city': instance.city,
  'state': instance.state,
};
