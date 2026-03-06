// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
  data: InvoiceData.fromJson(json['data'] as Map<String, dynamic>),
  id: (json['id'] as num?)?.toInt(),
  registrationDate: json['registration_date'] == null
      ? null
      : DateTime.parse(json['registration_date'] as String),
  lastUpdatedDate: json['last_updated_date'] == null
      ? null
      : DateTime.parse(json['last_updated_date'] as String),
);

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
  'id': instance.id,
  'registration_date': instance.registrationDate.toIso8601String(),
  'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
  'data': instance.data.toJson(),
};

InvoiceData _$InvoiceDataFromJson(Map<String, dynamic> json) => InvoiceData(
  invoiceNumber: json['numero_nota'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => InvoiceItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  paymentMethod: json['forma_pagamento'] as String,
  customerId: (json['cliente_id'] as num?)?.toInt(),
  customerName: json['cliente_nome'] as String?,
  customerCpf: json['cliente_cpf'] as String?,
  companyId: (json['empresa_id'] as num?)?.toInt(),
  issueDate: json['data_emissao'] == null
      ? null
      : DateTime.parse(json['data_emissao'] as String),
  type:
      $enumDecodeNullable(_$InvoiceTypeEnumMap, json['type']) ??
      InvoiceType.exit,
);

Map<String, dynamic> _$InvoiceDataToJson(InvoiceData instance) =>
    <String, dynamic>{
      'numero_nota': instance.invoiceNumber,
      'cliente_id': instance.customerId,
      'cliente_nome': instance.customerName,
      'cliente_cpf': instance.customerCpf,
      'empresa_id': instance.companyId,
      'items': instance.items,
      'forma_pagamento': instance.paymentMethod,
      'data_emissao': instance.issueDate.toIso8601String(),
      'type': _$InvoiceTypeEnumMap[instance.type]!,
    };

const _$InvoiceTypeEnumMap = {
  InvoiceType.entry: 'entry',
  InvoiceType.exit: 'exit',
};
