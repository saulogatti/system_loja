// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file
// ignore_for_file: cast_nullable_to_non_nullable, unnecessary_null_checks, unused_element, unnecessary_lambdas, inference_failure_on_collection_literal

part of 'individual_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndividualEntry _$IndividualEntryFromJson(Map<String, dynamic> json) =>
    IndividualEntry(
      name: json['name'] as String,
      document: const CpfConverter().fromJson(json['document'] as String),
      registrationDate: DateTime.parse(json['registrationDate'] as String),
      lastUpdatedDate: DateTime.parse(json['lastUpdatedDate'] as String),
      id: (json['id'] as num?)?.toInt() ?? -1,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$IndividualEntryToJson(IndividualEntry instance) =>
    <String, dynamic>{
      'name': instance.name,
      'document': const CpfConverter().toJson(instance.document),
      'registrationDate': instance.registrationDate.toIso8601String(),
      'lastUpdatedDate': instance.lastUpdatedDate.toIso8601String(),
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone,
    };
