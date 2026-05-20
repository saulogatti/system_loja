import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_type.dart';
import 'package:system_loja/data/database/app_database.dart';

/// Insere apenas cabeçalho + itens (sem movimentar estoque), para testes que usam itens fictícios.
Future<int> insertInvoiceAndItemsOnly(AppDatabase database, Invoice invoice) {
  return database.transaction(() async {
    final invoiceId = await database.invoiceDao.insertInvoice(invoice);
    for (final item in invoice.data.items) {
      await database.invoiceItemDao.insertInvoiceItem(
        item,
        invoiceId: invoiceId,
      );
    }
    return invoiceId;
  });
}

/// Replica a orquestração de [SalesRepository.saveSale] para testes de integração DAO.
Future<int> insertInvoiceWithItemsLikeRepository(
  AppDatabase database,
  Invoice invoice,
) async {
  if (invoice.data.type == InvoiceType.exit) {
    for (final item in invoice.data.items) {
      final product = await database.productDao.getById(item.productId);
      if (product == null || product.stockQuantity < item.quantity) {
        throw StateError('Estoque insuficiente');
      }
    }
  }

  return database.transaction(() async {
    final invoiceId = await database.invoiceDao.insertInvoice(invoice);
    for (final item in invoice.data.items) {
      await database.invoiceItemDao.insertInvoiceItem(
        item,
        invoiceId: invoiceId,
      );
      final quantityChange = invoice.data.type == InvoiceType.entry
          ? item.quantity
          : -item.quantity;
      final ok = await database.productDao.updateStockQuantity(
        item.productId,
        quantityChange,
      );
      if (!ok) {
        throw StateError('Falha ao atualizar estoque');
      }
    }
    return invoiceId;
  });
}
