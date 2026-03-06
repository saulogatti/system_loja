// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individual_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndividualEntry _$IndividualEntryFromJson(Map<String, dynamic> json) =>
    IndividualEntry(
      name: json['name'] as String,
      registrationDate: json['registration_date'] == null
          ? null
          : DateTime.parse(json['registration_date'] as String),
      lastUpdatedDate: json['last_updated_date'] == null
          ? null
          : DateTime.parse(json['last_updated_date'] as String),
      id: (json['id'] as num?)?.toInt() ?? -1,
      document: _$JsonConverterFromJson<String, Cpf>(
        json['document'],
        const CpfConverter().fromJson,
      ),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$IndividualEntryToJson(IndividualEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'registration_date': instance.registrationDate.toIso8601String(),
      'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'document': _$JsonConverterToJson<String, Cpf>(
        instance.document,
        const CpfConverter().toJson,
      ),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
