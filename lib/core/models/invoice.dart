import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/core/models/invoice_type.dart';

part 'invoice.g.dart';

/// Modelo de dados para Nota Fiscal.
@JsonSerializable(explicitToJson: true)
class Invoice extends DefaultObject {
  final InvoiceData data;

  Invoice({
    required this.data,
    super.registrationDate,
    super.lastUpdatedDate,
    super.id,
  });

  /// Cria um objeto a partir de JSON.
  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);

  /// Converte o objeto para JSON.
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeln('Invoice Number: ${data.invoiceNumber}');
    buffer.writeln('Type: ${data.type.name}');
    if (data.customerId != null) {
      buffer.writeln(
        'Customer: ${data.customerName} (CPF: ${data.customerCpf})',
      );
    }
    if (data.companyId != null) {
      buffer.writeln('Company ID: ${data.companyId}');
    }
    buffer.writeln('Total Value: R\$ ${data.totalValue.toStringAsFixed(2)}');
    buffer.writeln('Payment Method: ${data.paymentMethod}');
    buffer.writeln('Issue Date: ${data.issueDate.toString().split('.')[0]}');
    buffer.writeln('Items:');
    for (var item in data.items) {
      buffer.writeln(item.toString());
    }
    buffer.writeln(
      'Data de Cadastro: ${registrationDate.toString().split('.')[0]}',
    );
    buffer.writeln(
      'Data de Atualização: ${lastUpdatedDate.toString().split('.')[0]}',
    );
    return buffer.toString();
  }
}

/// Dados de uma nota fiscal.
///
/// Regra exclusiva: exatamente um de [customerId] ou [companyId] deve ser
/// informado, independente do [type].
@JsonSerializable()
class InvoiceData {
  @JsonKey(name: 'numero_nota')
  String invoiceNumber;

  /// ID do cliente quando a nota estiver vinculada a um cliente.
  @JsonKey(name: 'cliente_id')
  final int? customerId;

  /// Nome do cliente (desnormalizado).
  @JsonKey(name: 'cliente_nome')
  final String? customerName;

  /// CPF do cliente (desnormalizado).
  @JsonKey(name: 'cliente_cpf')
  final String? customerCpf;

  /// ID da empresa vinculada à nota.
  @JsonKey(name: 'empresa_id')
  final int? companyId;

  final List<InvoiceItem> items;
  @JsonKey(name: 'valor_total')
  final double totalValue;
  @JsonKey(name: 'forma_pagamento')
  final String paymentMethod;
  @JsonKey(name: 'data_emissao')
  final DateTime issueDate;

  /// Tipo da nota fiscal. Padrão: saída ([InvoiceType.exit]).
  final InvoiceType type;

  InvoiceData({
    required this.invoiceNumber,
    required this.items,
    required this.paymentMethod,
    this.customerId,
    this.customerName,
    this.customerCpf,
    this.companyId,
    DateTime? issueDate,
    this.type = InvoiceType.exit,
  }) : totalValue = items.fold(0.0, (sum, item) => sum + item.totalValue),
       issueDate = issueDate ?? DateTime.now() {
    final withoutLink = customerId == null && companyId == null;
    final withBothLinks = customerId != null && companyId != null;
    if (withoutLink || withBothLinks) {
      throw ArgumentError(
        'Informe exatamente um vínculo: customerId ou companyId.',
      );
    }
  }

  factory InvoiceData.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDataFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceDataToJson(this);
}
