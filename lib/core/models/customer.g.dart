// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
  name: json['name'] as String,
  cpf: json['cpf'] as String,
  id: (json['id'] as num?)?.toInt(),
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  address: json['address'] == null
      ? null
      : Address.fromJson(json['address'] as Map<String, dynamic>),
  registrationDate: json['registration_date'] == null
      ? null
      : DateTime.parse(json['registration_date'] as String),
  lastUpdatedDate: json['last_updated_date'] == null
      ? null
      : DateTime.parse(json['last_updated_date'] as String),
);

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
  'id': instance.id,
  'registration_date': instance.registrationDate.toIso8601String(),
  'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'cpf': instance.cpf,
  'address': instance.address.toJson(),
};
