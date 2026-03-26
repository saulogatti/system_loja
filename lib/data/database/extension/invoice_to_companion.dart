import 'package:drift/drift.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/data/database/app_database.dart';

/// Extensão para converter [InvoicesRecord] (Drift) para [Invoice] (domínio).
extension InvoiceFromData on InvoicesRecord {
  /// Converte um registro do banco de dados para o modelo de domínio [Invoice].
  ///
  /// Nota: os itens da nota fiscal devem ser carregados separadamente
  /// usando `InvoiceItemDao.getByInvoiceId()`.
  Invoice toDomain(List<InvoiceItem> items) {
    return Invoice(
      id: id,
      data: InvoiceData(
        invoiceNumber: invoiceNumber,
        customerId: customerId,
        customerName: customerName,
        customerCpf: customerCpf,
        companyId: companyId,
        companyName: companyName,
        companyCnpj: companyCnpj,
        type: type,
        items: items,
        paymentMethod: paymentMethod,
        issueDate: issueDate,
      ),
      registrationDate: registrationDate,
      lastUpdatedDate: lastUpdatedDate,
    );
  }
}

/// Extensão para converter [Invoice] (domínio) para [InvoicesRecordsCompanion] (Drift).
extension InvoiceToCompanion on Invoice {
  /// Converte um modelo de domínio [Invoice] para Companion usado em insert/update.
  ///
  /// Para inserções, usa `.insert()`. Para atualizações, inclui o ID.
  InvoicesRecordsCompanion toCompanion({bool forUpdate = false}) {
    if (forUpdate) {
      return InvoicesRecordsCompanion(
        id: Value(id),
        invoiceNumber: Value(data.invoiceNumber),
        customerId: Value(data.customerId),
        customerName: Value(data.customerName),
        customerCpf: Value(data.customerCpf),
        companyId: Value(data.companyId),
        companyName: Value(data.companyName),
        companyCnpj: Value(data.companyCnpj),
        type: Value(data.type),
        totalValue: Value(data.totalValue),
        paymentMethod: Value(data.paymentMethod),
        issueDate: Value(data.issueDate),
        lastUpdatedDate: Value(DateTime.now()),
        registrationDate: Value(registrationDate),
      );
    }
    return InvoicesRecordsCompanion.insert(
      invoiceNumber: data.invoiceNumber,
      customerId: Value(data.customerId),
      customerName: Value(data.customerName),
      customerCpf: Value(data.customerCpf),
      companyId: Value(data.companyId),
      companyName: Value(data.companyName),
      companyCnpj: Value(data.companyCnpj),
      type: Value(data.type),
      totalValue: data.totalValue,
      paymentMethod: data.paymentMethod,
      issueDate: data.issueDate,
      lastUpdatedDate: Value(lastUpdatedDate),
      registrationDate: Value(registrationDate),
    );
  }
}

/// Extensão para converter [InvoiceItemsRecord] (Drift) para [InvoiceItem] (domínio).
extension InvoiceItemFromData on InvoiceItemsRecord {
  /// Converte um registro do banco de dados para o modelo de domínio [InvoiceItem].
  InvoiceItem toDomain() {
    return InvoiceItem(
      productId: productId,
      productName: productName,
      productCode: productCode,
      quantity: quantity,
      unitPrice: unitPrice,
    );
  }
}

/// Extensão para converter [InvoiceItem] (domínio) para [InvoiceItemsRecordsCompanion] (Drift).
extension InvoiceItemToCompanion on InvoiceItem {
  /// Converte um modelo de domínio [InvoiceItem] para Companion usado em insert.
  ///
  /// Requer o [invoiceId] para estabelecer o relacionamento com a nota fiscal.
  InvoiceItemsRecordsCompanion toCompanion({required int invoiceId, bool forUpdate = false}) {
    if (forUpdate) {
      throw UnimplementedError('Update de InvoiceItem não suportado. Delete e reinsira os itens.');
    }
    return InvoiceItemsRecordsCompanion.insert(
      invoiceId: invoiceId,
      productId: productId,
      productName: productName,
      productCode: productCode,
      quantity: quantity,
      unitPrice: unitPrice,
      totalValue: totalValue,
    );
  }
}
