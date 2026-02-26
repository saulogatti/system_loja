// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Invoice',
      json,
      ($checkedConvert) {
        final val = Invoice(
          id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
          data: $checkedConvert(
              'data', (v) => InvoiceData.fromJson(v as Map<String, dynamic>)),
          registrationDate: $checkedConvert('registration_date',
              (v) => v == null ? null : DateTime.parse(v as String)),
          lastUpdatedDate: $checkedConvert('last_updated_date',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'registrationDate': 'registration_date',
        'lastUpdatedDate': 'last_updated_date'
      },
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'id': instance.id,
      'registration_date': instance.registrationDate.toIso8601String(),
      'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
      'data': instance.data.toJson(),
    };

InvoiceData _$InvoiceDataFromJson(Map<String, dynamic> json) => $checkedCreate(
      'InvoiceData',
      json,
      ($checkedConvert) {
        final val = InvoiceData(
          invoiceNumber: $checkedConvert('numero_nota', (v) => v as String),
          customerId:
              $checkedConvert('cliente_id', (v) => (v as num?)?.toInt()),
          customerName: $checkedConvert('cliente_nome', (v) => v as String?),
          customerCpf: $checkedConvert('cliente_cpf', (v) => v as String?),
          companyId: $checkedConvert('empresa_id', (v) => (v as num?)?.toInt()),
          items: $checkedConvert(
              'items',
              (v) => (v as List<dynamic>)
                  .map((e) => InvoiceItem.fromJson(e as Map<String, dynamic>))
                  .toList()),
          paymentMethod: $checkedConvert('forma_pagamento', (v) => v as String),
          issueDate: $checkedConvert('data_emissao',
              (v) => v == null ? null : DateTime.parse(v as String)),
          type: $checkedConvert(
              'type',
              (v) =>
                  $enumDecodeNullable(_$InvoiceTypeEnumMap, v) ??
                  InvoiceType.exit),
        );
        return val;
      },
      fieldKeyMap: const {
        'invoiceNumber': 'numero_nota',
        'customerId': 'cliente_id',
        'customerName': 'cliente_nome',
        'customerCpf': 'cliente_cpf',
        'companyId': 'empresa_id',
        'paymentMethod': 'forma_pagamento',
        'issueDate': 'data_emissao'
      },
    );

Map<String, dynamic> _$InvoiceDataToJson(InvoiceData instance) =>
    <String, dynamic>{
      'numero_nota': instance.invoiceNumber,
      'cliente_id': instance.customerId,
      'cliente_nome': instance.customerName,
      'cliente_cpf': instance.customerCpf,
      'empresa_id': instance.companyId,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'forma_pagamento': instance.paymentMethod,
      'data_emissao': instance.issueDate.toIso8601String(),
      'type': _$InvoiceTypeEnumMap[instance.type]!,
    };

const _$InvoiceTypeEnumMap = {
  InvoiceType.entry: 'entry',
  InvoiceType.exit: 'exit',
};
