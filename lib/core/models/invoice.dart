import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/core/models/invoice_type.dart';

/// Nota fiscal (domínio). Serialização em `lib/data/models/invoice_export_data.dart`.
class Invoice extends DefaultObject {
  final InvoiceData data;

  Invoice({
    required this.data,
    super.registrationDate,
    super.lastUpdatedDate,
    super.id,
  });

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

/// Dados da nota fiscal.
///
/// Exatamente um de [customerId] ou [companyId] deve ser informado.
class InvoiceData {
  String invoiceNumber;
  final int? customerId;
  final String? customerName;
  final String? customerCpf;
  final int? companyId;
  final List<InvoiceItem> items;
  final double totalValue;
  final String paymentMethod;
  final DateTime issueDate;
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
}
