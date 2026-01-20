// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Customer',
  json,
  ($checkedConvert) {
    final val = Customer.withData(
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      customerInfo: $checkedConvert(
        'customerInfo',
        (v) => CustomerInfo.fromJson(v as Map<String, dynamic>),
      ),
      registrationDate: $checkedConvert(
        'registration_date',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      lastUpdatedDate: $checkedConvert(
        'last_updated_date',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'registrationDate': 'registration_date',
    'lastUpdatedDate': 'last_updated_date',
  },
);

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
  'id': instance.id,
  'registration_date': instance.registrationDate.toIso8601String(),
  'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
  'customerInfo': instance.customerInfo.toJson(),
};

CustomerInfo _$CustomerInfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CustomerInfo', json, ($checkedConvert) {
      final val = CustomerInfo(
        name: $checkedConvert('name', (v) => v as String),
        cpf: $checkedConvert('cpf', (v) => v as String),
        email: $checkedConvert('email', (v) => v as String),
        phone: $checkedConvert('phone', (v) => v as String),
        address: $checkedConvert('address', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$CustomerInfoToJson(CustomerInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'cpf': instance.cpf,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
    };
