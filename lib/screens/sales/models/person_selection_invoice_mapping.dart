import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/core/models/invoice_type.dart';
import 'package:system_loja/screens/sales/models/person_selection.dart';

/// Monta [InvoiceData] a partir da pessoa selecionada (cliente ou empresa).
extension PersonSelectionInvoiceMapping on PersonSelection {
  /// Constrói os dados da nota com vínculo de cliente ou empresa.
  InvoiceData toInvoiceData({
    required String invoiceNumber,
    required InvoiceType type,
    required List<InvoiceItem> items,
    required String paymentMethod,
  }) => switch (this) {
      CustomerSelection(:final customer) => InvoiceData(
        invoiceNumber: invoiceNumber,
        type: type,
        customerId: customer.id,
        customerName: customer.name,
        customerCpf: customer.cpf,
        items: items,
        paymentMethod: paymentMethod,
      ),
      CompanySelection(:final company) => InvoiceData(
        invoiceNumber: invoiceNumber,
        type: type,
        companyId: company.id,
        companyName: company.name,
        companyCnpj: company.cnpj,
        items: items,
        paymentMethod: paymentMethod,
      ),
    };
}
