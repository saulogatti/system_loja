// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
  id: (json['id'] as num).toInt(),
  data: InvoiceData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
  'id': instance.id,
  'data': instance.data.toJson(),
};

InvoiceData _$InvoiceDataFromJson(Map<String, dynamic> json) => InvoiceData(
  invoiceNumber: json['numero_nota'] as String,
  customerId: (json['cliente_id'] as num).toInt(),
  customerName: json['cliente_nome'] as String,
  customerCpf: json['cliente_cpf'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => InvoiceItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  paymentMethod: json['forma_pagamento'] as String,
  issueDate: json['data_emissao'] == null
      ? null
      : DateTime.parse(json['data_emissao'] as String),
);

Map<String, dynamic> _$InvoiceDataToJson(InvoiceData instance) =>
    <String, dynamic>{
      'numero_nota': instance.invoiceNumber,
      'cliente_id': instance.customerId,
      'cliente_nome': instance.customerName,
      'cliente_cpf': instance.customerCpf,
      'items': instance.items,
      'forma_pagamento': instance.paymentMethod,
      'data_emissao': instance.issueDate.toIso8601String(),
    };
