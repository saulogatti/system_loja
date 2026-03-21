import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_type.dart';
import 'package:system_loja/data/models/invoice_item_data.dart';

part 'invoice_export_data.g.dart';

/// JSON para importação/exportação de [Invoice].
@JsonSerializable(explicitToJson: true)
class InvoiceExportData {
  final int id;
  final DateTime registrationDate;
  final DateTime lastUpdatedDate;
  final InvoiceDataExport data;

  const InvoiceExportData({
    required this.id,
    required this.registrationDate,
    required this.lastUpdatedDate,
    required this.data,
  });

  factory InvoiceExportData.fromJson(Map<String, dynamic> json) =>
      _$InvoiceExportDataFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceExportDataToJson(this);

  factory InvoiceExportData.fromDomain(Invoice value) => InvoiceExportData(
        id: value.id,
        registrationDate: value.registrationDate,
        lastUpdatedDate: value.lastUpdatedDate,
        data: InvoiceDataExport.fromDomain(value.data),
      );

  Invoice toDomain() => Invoice(
        id: id,
        registrationDate: registrationDate,
        lastUpdatedDate: lastUpdatedDate,
        data: data.toDomain(),
      );
}

@JsonSerializable(explicitToJson: true)
class InvoiceDataExport {
  @JsonKey(name: 'numero_nota')
  final String invoiceNumber;
  @JsonKey(name: 'cliente_id')
  final int? customerId;
  @JsonKey(name: 'cliente_nome')
  final String? customerName;
  @JsonKey(name: 'cliente_cpf')
  final String? customerCpf;
  @JsonKey(name: 'empresa_id')
  final int? companyId;
  final List<InvoiceItemData> items;
  @JsonKey(name: 'forma_pagamento')
  final String paymentMethod;
  @JsonKey(name: 'data_emissao')
  final DateTime issueDate;

  @JsonKey(fromJson: _invoiceTypeFromJson, toJson: _invoiceTypeToJson)
  final InvoiceType type;

  const InvoiceDataExport({
    required this.invoiceNumber,
    required this.items,
    required this.paymentMethod,
    required this.issueDate, this.customerId,
    this.customerName,
    this.customerCpf,
    this.companyId,
    this.type = InvoiceType.exit,
  });

  factory InvoiceDataExport.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDataExportFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDataExportToJson(this);

  factory InvoiceDataExport.fromDomain(InvoiceData value) => InvoiceDataExport(
        invoiceNumber: value.invoiceNumber,
        customerId: value.customerId,
        customerName: value.customerName,
        customerCpf: value.customerCpf,
        companyId: value.companyId,
        items: value.items.map(InvoiceItemData.fromDomain).toList(),
        paymentMethod: value.paymentMethod,
        issueDate: value.issueDate,
        type: value.type,
      );

  InvoiceData toDomain() => InvoiceData(
        invoiceNumber: invoiceNumber,
        customerId: customerId,
        customerName: customerName,
        customerCpf: customerCpf,
        companyId: companyId,
        items: items.map((e) => e.toDomain()).toList(),
        paymentMethod: paymentMethod,
        issueDate: issueDate,
        type: type,
      );

  static InvoiceType _invoiceTypeFromJson(Object? json) =>
      InvoiceType.values.byName(json as String);

  static String _invoiceTypeToJson(InvoiceType value) => value.name;
}
