// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_data_storage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersistentDataStore _$PersistentDataStoreFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PersistentDataStore', json, ($checkedConvert) {
      final val = PersistentDataStore(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        data: $checkedConvert('data', (v) => v as Map<String, dynamic>),
      );
      return val;
    });

Map<String, dynamic> _$PersistentDataStoreToJson(
  PersistentDataStore instance,
) => <String, dynamic>{'id': instance.id, 'data': instance.data};
