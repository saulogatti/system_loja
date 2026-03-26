// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerData _$CustomerDataFromJson(Map<String, dynamic> json) => CustomerData(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  cpf: json['cpf'] as String,
  address: AddressData.fromJson(json['address'] as Map<String, dynamic>),
  registrationDate: DateTime.parse(json['registrationDate'] as String),
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  lastUpdatedDate: json['lastUpdatedDate'] == null ? null : DateTime.parse(json['lastUpdatedDate'] as String),
);

Map<String, dynamic> _$CustomerDataToJson(CustomerData instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'cpf': instance.cpf,
  'phone': instance.phone,
  'email': instance.email,
  'address': instance.address.toJson(),
  'registrationDate': instance.registrationDate.toIso8601String(),
  'lastUpdatedDate': instance.lastUpdatedDate?.toIso8601String(),
};
