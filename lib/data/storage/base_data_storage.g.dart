// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_data_storage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersistentDataStore _$PersistentDataStoreFromJson(Map<String, dynamic> json) =>
    PersistentDataStore(
      id: (json['id'] as num).toInt(),
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$PersistentDataStoreToJson(
  PersistentDataStore instance,
) => <String, dynamic>{'id': instance.id, 'data': instance.data};
