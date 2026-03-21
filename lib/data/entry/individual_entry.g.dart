// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individual_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndividualEntry _$IndividualEntryFromJson(Map<String, dynamic> json) =>
    IndividualEntry(
      name: json['name'] as String,
      document: const CpfConverter().fromJson(json['document'] as String),
      registrationDate: json['registrationDate'] == null
          ? null
          : DateTime.parse(json['registrationDate'] as String),
      lastUpdatedDate: json['lastUpdatedDate'] == null
          ? null
          : DateTime.parse(json['lastUpdatedDate'] as String),
      id: (json['id'] as num?)?.toInt(),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$IndividualEntryToJson(IndividualEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'registrationDate': instance.registrationDate.toIso8601String(),
      'lastUpdatedDate': instance.lastUpdatedDate.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'document': const CpfConverter().toJson(instance.document),
    };
