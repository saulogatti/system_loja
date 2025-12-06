// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer.withData(
  id: (json['id'] as num).toInt(),
  customerInfo: CustomerInfo.fromJson(
    json['customerInfo'] as Map<String, dynamic>,
  ),
  registrationDate: json['registration_date'] == null
      ? null
      : DateTime.parse(json['registration_date'] as String),
);

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
  'id': instance.id,
  'customerInfo': instance.customerInfo.toJson(),
  'registration_date': instance.registrationDate.toIso8601String(),
};

CustomerInfo _$CustomerInfoFromJson(Map<String, dynamic> json) => CustomerInfo(
  name: json['name'] as String,
  cpf: json['cpf'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  address: json['address'] as String,
);

Map<String, dynamic> _$CustomerInfoToJson(CustomerInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'cpf': instance.cpf,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
    };
