// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'obejct_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObejctRepositoryBase _$ObejctRepositoryBaseFromJson(
  Map<String, dynamic> json,
) => ObejctRepositoryBase(
  json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ObejctRepositoryBaseToJson(
  ObejctRepositoryBase instance,
) => <String, dynamic>{
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
