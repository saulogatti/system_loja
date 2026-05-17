// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressData _$AddressDataFromJson(Map<String, dynamic> json) => AddressData(
  street: json['street'] as String? ?? '',
  zipCode: json['zipCode'] as String? ?? '',
  neighborhood: json['neighborhood'] as String? ?? '',
  city: json['city'] as String? ?? '',
  state: json['state'] as String? ?? '',
);

Map<String, dynamic> _$AddressDataToJson(AddressData instance) =>
    <String, dynamic>{
      'street': instance.street,
      'zipCode': instance.zipCode,
      'neighborhood': instance.neighborhood,
      'city': instance.city,
      'state': instance.state,
    };
