// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Company',
  json,
  ($checkedConvert) {
    final val = Company(
      id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
      corporateName: $checkedConvert('corporateName', (v) => v as String),
      cnpj: $checkedConvert('cnpj', (v) => v as String),
      email: $checkedConvert('email', (v) => v as String?),
      street: $checkedConvert('street', (v) => v as String?),
      zipCode: $checkedConvert('zipCode', (v) => v as String?),
      neighborhood: $checkedConvert('neighborhood', (v) => v as String?),
      city: $checkedConvert('city', (v) => v as String?),
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

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
  'id': instance.id,
  'registration_date': instance.registrationDate.toIso8601String(),
  'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
  'corporateName': instance.corporateName,
  'cnpj': instance.cnpj,
  'email': instance.email,
  'street': instance.street,
  'zipCode': instance.zipCode,
  'neighborhood': instance.neighborhood,
  'city': instance.city,
};
