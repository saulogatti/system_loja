import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/core/models/invoice_type.dart';

/// Nota fiscal (domínio). Serialização em `lib/data/models/invoice_export_data.dart`.
///
/// Representa uma nota fiscal de entrada ([InvoiceType.entry]) ou saída
/// ([InvoiceType.exit]). Os dados da nota estão encapsulados em [InvoiceData].
class Invoice extends DefaultObject {
  /// Dados da nota fiscal (número, tipo, itens, valores, etc.).
  final InvoiceData data;

  Invoice({required this.data, super.registrationDate, super.lastUpdatedDate, super.id});

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeln('Invoice Number: ${data.invoiceNumber}');
    buffer.writeln('Type: ${data.type.name}');
    if (data.customerId != null) {
      buffer.writeln('Customer: ${data.customerName} (CPF: ${data.customerCpf})');
    }
    if (data.companyId != null) {
      buffer.writeln('Company: ${data.companyName} (CNPJ: ${data.companyCnpj})');
    }
    buffer.writeln('Total Value: R\$ ${data.totalValue.toStringAsFixed(2)}');
    buffer.writeln('Payment Method: ${data.paymentMethod}');
    buffer.writeln('Issue Date: ${data.issueDate.toString().split('.')[0]}');
    buffer.writeln('Items:');
    for (var item in data.items) {
      buffer.writeln(item.toString());
    }
    buffer.writeln('Data de Cadastro: ${registrationDate.toString().split('.')[0]}');
    buffer.writeln('Data de Atualização: ${lastUpdatedDate.toString().split('.')[0]}');
    return buffer.toString();
  }
}

/// Dados da nota fiscal.
///
/// Exatamente um de [customerId] ou [companyId] deve ser informado.
/// Notas de saída ([InvoiceType.exit]) vinculam a clientes; notas de entrada
/// ([InvoiceType.entry]) vinculam a empresas.
///
/// O [totalValue] é calculado automaticamente a partir da soma dos [items].
class InvoiceData {
  /// Número único da nota fiscal (ex.: NF-20260123-0001).
  String invoiceNumber;

  /// ID do cliente vinculado (mutuamente exclusivo com [companyId]).
  final int? customerId;

  /// Nome do cliente para exibição (desnormalizado).
  final String? customerName;

  /// CPF do cliente para exibição (desnormalizado).
  final String? customerCpf;

  /// ID da empresa vinculada (mutuamente exclusivo com [customerId]).
  final int? companyId;

  /// Nome da empresa para exibição (desnormalizado).
  final String? companyName;

  /// CNPJ da empresa para exibição (desnormalizado).
  final String? companyCnpj;

  /// Itens da nota fiscal.
  final List<InvoiceItem> items;

  /// Valor total calculado automaticamente a partir dos [items].
  final double totalValue;

  /// Forma de pagamento utilizada.
  final String paymentMethod;

  /// Data de emissão da nota. Padrão: data/hora atual.
  final DateTime issueDate;

  /// Tipo da nota: entrada ([InvoiceType.entry]) ou saída ([InvoiceType.exit]).
  final InvoiceType type;

  InvoiceData({
    required this.invoiceNumber,
    required this.items,
    required this.paymentMethod,
    this.customerId,
    this.customerName,
    this.customerCpf,
    this.companyId,
    this.companyName,
    this.companyCnpj,
    DateTime? issueDate,
    this.type = InvoiceType.exit,
  }) : totalValue = items.fold(0.0, (sum, item) => sum + item.totalValue),
       issueDate = issueDate ?? DateTime.now() {
    final withoutLink = customerId == null && companyId == null;
    final withBothLinks = customerId != null && companyId != null;
    if (withoutLink || withBothLinks) {
      throw ArgumentError('Informe exatamente um vínculo: customerId ou companyId.');
    }
  }

  /// Nome de exibição unificado (cliente ou empresa).
  String get personDisplayName => customerName ?? companyName ?? '';

  /// Documento de exibição unificado (CPF ou CNPJ).
  String get personDocument => customerCpf ?? companyCnpj ?? '';
}
