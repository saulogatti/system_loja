// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_export_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceDataExport _$InvoiceDataExportFromJson(Map<String, dynamic> json) => InvoiceDataExport(
  invoiceNumber: json['invoiceNumber'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => InvoiceItemData.fromJson(e as Map<String, dynamic>))
      .toList(),
  paymentMethod: json['paymentMethod'] as String,
  issueDate: DateTime.parse(json['issueDate'] as String),
  customerId: (json['customerId'] as num?)?.toInt(),
  customerName: json['customerName'] as String?,
  customerCpf: json['customerCpf'] as String?,
  companyId: (json['companyId'] as num?)?.toInt(),
  companyName: json['companyName'] as String?,
  companyCnpj: json['companyCnpj'] as String?,
  type: json['type'] == null ? InvoiceType.exit : InvoiceDataExport._invoiceTypeFromJson(json['type']),
);

Map<String, dynamic> _$InvoiceDataExportToJson(InvoiceDataExport instance) => <String, dynamic>{
  'invoiceNumber': instance.invoiceNumber,
  'customerId': instance.customerId,
  'customerName': instance.customerName,
  'customerCpf': instance.customerCpf,
  'companyId': instance.companyId,
  'companyName': instance.companyName,
  'companyCnpj': instance.companyCnpj,
  'items': instance.items.map((e) => e.toJson()).toList(),
  'paymentMethod': instance.paymentMethod,
  'issueDate': instance.issueDate.toIso8601String(),
  'type': InvoiceDataExport._invoiceTypeToJson(instance.type),
};

InvoiceExportData _$InvoiceExportDataFromJson(Map<String, dynamic> json) => InvoiceExportData(
  id: (json['id'] as num).toInt(),
  registrationDate: DateTime.parse(json['registrationDate'] as String),
  lastUpdatedDate: DateTime.parse(json['lastUpdatedDate'] as String),
  data: InvoiceDataExport.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$InvoiceExportDataToJson(InvoiceExportData instance) => <String, dynamic>{
  'id': instance.id,
  'registrationDate': instance.registrationDate.toIso8601String(),
  'lastUpdatedDate': instance.lastUpdatedDate.toIso8601String(),
  'data': instance.data.toJson(),
};
