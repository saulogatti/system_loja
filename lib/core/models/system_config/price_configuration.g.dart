// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceConfiguration _$PriceConfigurationFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PriceConfiguration',
      json,
      ($checkedConvert) {
        final val = PriceConfiguration(
          types: $checkedConvert(
            'types',
            (v) => (v as List<dynamic>)
                .map((e) => $enumDecode(_$PaymentMethodTypeEnumMap, e))
                .toList(),
          ),
          lastUpdatedDate: $checkedConvert(
            'last_updated_date',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          registrationDate: $checkedConvert(
            'registration_date',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'lastUpdatedDate': 'last_updated_date',
        'registrationDate': 'registration_date',
      },
    );

Map<String, dynamic> _$PriceConfigurationToJson(
  PriceConfiguration instance,
) => <String, dynamic>{
  'id': instance.id,
  'registration_date': instance.registrationDate.toIso8601String(),
  'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
  'types': instance.types.map((e) => _$PaymentMethodTypeEnumMap[e]!).toList(),
};

const _$PaymentMethodTypeEnumMap = {
  PaymentMethodType.cash: 'cash',
  PaymentMethodType.card: 'card',
  PaymentMethodType.pix: 'pix',
  PaymentMethodType.other: 'other',
};
