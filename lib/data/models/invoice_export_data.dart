import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_type.dart';
import 'package:system_loja/data/models/invoice_item_data.dart';

part 'invoice_export_data.g.dart';

@JsonSerializable(explicitToJson: true)
class InvoiceDataExport {

  const InvoiceDataExport({
    required this.invoiceNumber,
    required this.items,
    required this.paymentMethod,
    required this.issueDate,
    this.customerId,
    this.customerName,
    this.customerCpf,
    this.companyId,
    this.companyName,
    this.companyCnpj,
    this.type = InvoiceType.exit,
  });

  factory InvoiceDataExport.fromDomain(InvoiceData value) => InvoiceDataExport(
    invoiceNumber: value.invoiceNumber,
    customerId: value.customerId,
    customerName: value.customerName,
    customerCpf: value.customerCpf,
    companyId: value.companyId,
    companyName: value.companyName,
    companyCnpj: value.companyCnpj,
    items: value.items.map(InvoiceItemData.fromDomain).toList(),
    paymentMethod: value.paymentMethod,
    issueDate: value.issueDate,
    type: value.type,
  );

  factory InvoiceDataExport.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDataExportFromJson(json);
  final String invoiceNumber;

  final int? customerId;

  final String? customerName;

  final String? customerCpf;

  final int? companyId;

  final String? companyName;

  final String? companyCnpj;
  final List<InvoiceItemData> items;

  final String paymentMethod;

  final DateTime issueDate;

  @JsonKey(fromJson: _invoiceTypeFromJson, toJson: _invoiceTypeToJson)
  final InvoiceType type;

  InvoiceData toDomain() => InvoiceData(
    invoiceNumber: invoiceNumber,
    customerId: customerId,
    customerName: customerName,
    customerCpf: customerCpf,
    companyId: companyId,
    companyName: companyName,
    companyCnpj: companyCnpj,
    items: items.map((e) => e.toDomain()).toList(),
    paymentMethod: paymentMethod,
    issueDate: issueDate,
    type: type,
  );

  Map<String, dynamic> toJson() => _$InvoiceDataExportToJson(this);

  static InvoiceType _invoiceTypeFromJson(Object? json) =>
      InvoiceType.values.byName(json! as String);

  static String _invoiceTypeToJson(InvoiceType value) => value.name;
}

/// JSON para importação/exportação de [Invoice].
@JsonSerializable(explicitToJson: true)
class InvoiceExportData {

  const InvoiceExportData({
    required this.id,
    required this.registrationDate,
    required this.lastUpdatedDate,
    required this.data,
  });

  factory InvoiceExportData.fromDomain(Invoice value) => InvoiceExportData(
    id: value.id,
    registrationDate: value.registrationDate,
    lastUpdatedDate: value.lastUpdatedDate,
    data: InvoiceDataExport.fromDomain(value.data),
  );

  factory InvoiceExportData.fromJson(Map<String, dynamic> json) =>
      _$InvoiceExportDataFromJson(json);
  final int id;
  final DateTime registrationDate;
  final DateTime lastUpdatedDate;
  final InvoiceDataExport data;

  Invoice toDomain() => Invoice(
    id: id,
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
    data: data.toDomain(),
  );

  Map<String, dynamic> toJson() => _$InvoiceExportDataToJson(this);
}
