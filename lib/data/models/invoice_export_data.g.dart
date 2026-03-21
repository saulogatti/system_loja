// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_export_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceExportData _$InvoiceExportDataFromJson(Map<String, dynamic> json) =>
    InvoiceExportData(
      id: (json['id'] as num).toInt(),
      registrationDate: DateTime.parse(json['registrationDate'] as String),
      lastUpdatedDate: DateTime.parse(json['lastUpdatedDate'] as String),
      data: InvoiceDataExport.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvoiceExportDataToJson(InvoiceExportData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'registrationDate': instance.registrationDate.toIso8601String(),
      'lastUpdatedDate': instance.lastUpdatedDate.toIso8601String(),
      'data': instance.data.toJson(),
    };

InvoiceDataExport _$InvoiceDataExportFromJson(Map<String, dynamic> json) =>
    InvoiceDataExport(
      invoiceNumber: json['numero_nota'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => InvoiceItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentMethod: json['forma_pagamento'] as String,
      issueDate: DateTime.parse(json['data_emissao'] as String),
      customerId: (json['cliente_id'] as num?)?.toInt(),
      customerName: json['cliente_nome'] as String?,
      customerCpf: json['cliente_cpf'] as String?,
      companyId: (json['empresa_id'] as num?)?.toInt(),
      type: json['type'] == null
          ? InvoiceType.exit
          : InvoiceDataExport._invoiceTypeFromJson(json['type']),
    );

Map<String, dynamic> _$InvoiceDataExportToJson(InvoiceDataExport instance) =>
    <String, dynamic>{
      'numero_nota': instance.invoiceNumber,
      'cliente_id': instance.customerId,
      'cliente_nome': instance.customerName,
      'cliente_cpf': instance.customerCpf,
      'empresa_id': instance.companyId,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'forma_pagamento': instance.paymentMethod,
      'data_emissao': instance.issueDate.toIso8601String(),
      'type': InvoiceDataExport._invoiceTypeToJson(instance.type),
    };
