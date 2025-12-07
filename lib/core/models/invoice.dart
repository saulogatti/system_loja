import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/invoice_item.dart';

part 'invoice.g.dart';

/// Modelo de dados para Nota Fiscal
@JsonSerializable(explicitToJson: true)
class Invoice extends DefaultObject {
  final InvoiceData data;

  Invoice({required super.id, required this.data});

  /// Cria um objeto a partir de JSON
  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);

  /// Converte o objeto para JSON
  @override
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('ID: $id');
    buffer.writeln('Invoice Number: ${data.invoiceNumber}');
    buffer.writeln('Customer: ${data.customerName} (CPF: ${data.customerCpf})');
    buffer.writeln('Total Value: R\$ ${data.totalValue.toStringAsFixed(2)}');
    buffer.writeln('Payment Method: ${data.paymentMethod}');
    buffer.writeln('Issue Date: ${data.issueDate.toString().split('.')[0]}');
    buffer.writeln('Items:');
    for (var item in data.items) {
      buffer.writeln(item.toString());
    }
    return buffer.toString();
  }
}

@JsonSerializable()
class InvoiceData {
  @JsonKey(name: 'numero_nota')
  final String invoiceNumber;
  @JsonKey(name: 'cliente_id')
  final int customerId;
  @JsonKey(name: 'cliente_nome')
  final String customerName;
  @JsonKey(name: 'cliente_cpf')
  final String customerCpf;
  final List<InvoiceItem> items;
  @JsonKey(name: 'valor_total')
  final double totalValue;
  @JsonKey(name: 'forma_pagamento')
  final String paymentMethod;
  @JsonKey(name: 'data_emissao')
  final DateTime issueDate;
  InvoiceData({
    required this.invoiceNumber,
    required this.customerId,
    required this.customerName,
    required this.customerCpf,
    required this.items,
    required this.paymentMethod,
    DateTime? issueDate,
  }) : totalValue = items.fold(0.0, (sum, item) => sum + item.totalValue),
       issueDate = issueDate ?? DateTime.now();

  factory InvoiceData.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDataFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceDataToJson(this);
}
