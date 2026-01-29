import 'package:drift/drift.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/extension/invoice_to_companion.dart';
import 'package:system_loja/data/database/table/invoices_records.dart';

part 'invoice_dao.g.dart';

/// DAO para gerenciar operações CRUD de notas fiscais no banco de dados Drift.
///
/// Utiliza o padrão Repository e conversões entre Invoice (domínio) e
/// InvoicesRecord (Drift) através de extensões.
@DriftAccessor(tables: [InvoicesRecords])
class InvoiceDao extends DatabaseAccessor<AppDatabase> with _$InvoiceDaoMixin {
  InvoiceDao(super.db);

  /// Remove uma nota fiscal do banco de dados pelo ID.
  ///
  /// Nota: Os itens da nota devem ser removidos separadamente ou
  /// através de cascade delete se configurado.
  /// Retorna o número de linhas afetadas (normalmente 1 ou 0).
  Future<int> deleteInvoice(int id) {
    return (delete(invoicesRecords)..where((t) => t.id.equals(id))).go();
  }

  /// Retorna todas as notas fiscais como objetos de domínio Invoice.
  ///
  /// Carrega os itens de cada nota fiscal automaticamente.
  Future<List<Invoice>> getAll() async {
    final records = await select(invoicesRecords).get();
    if (records.isEmpty) return [];

    final invoiceIds = records.map((r) => r.id).toList();

    // Fetch all items for all invoices in a single query
    final itemRecords = await (select(
      db.invoiceItemsRecords,
    )..where((t) => t.invoiceId.isIn(invoiceIds))).get();

    // Group items by invoice ID for efficient lookup
    final itemsByInvoiceId = <int, List<InvoiceItem>>{};
    for (final itemRecord in itemRecords) {
      (itemsByInvoiceId[itemRecord.invoiceId] ??= []).add(
        itemRecord.toDomain(),
      );
    }

    // Build domain objects
    return [
      for (final record in records)
        record.toDomain(itemsByInvoiceId[record.id] ?? []),
    ];
  }

  /// Busca uma nota fiscal pelo ID.
  ///
  /// Carrega os itens da nota fiscal automaticamente.
  /// Retorna null se a nota fiscal não for encontrada.
  Future<Invoice?> getById(int id) async {
    final record = await (select(
      invoicesRecords,
    )..where((t) => t.id.equals(id))).getSingleOrNull();

    if (record == null) return null;

    final invoiceItemDao = db.invoiceItemDao;
    final items = await invoiceItemDao.getByInvoiceId(record.id);
    return record.toDomain(items);
  }

  /// Busca uma nota fiscal pelo número da nota.
  ///
  /// [invoiceNumber] Número da nota fiscal a ser buscada.
  /// Retorna a nota fiscal encontrada ou null se não existir.
  Future<Invoice?> getByInvoiceNumber(String invoiceNumber) async {
    final record = await (select(
      invoicesRecords,
    )..where((t) => t.invoiceNumber.equals(invoiceNumber))).getSingleOrNull();

    if (record == null) return null;

    final invoiceItemDao = db.invoiceItemDao;
    final items = await invoiceItemDao.getByInvoiceId(record.id);
    return record.toDomain(items);
  }

  /// Insere uma nova nota fiscal no banco de dados.
  ///
  /// Aceita um objeto Invoice do domínio e o converte para Companion.
  /// Os itens da nota devem ser inseridos separadamente usando InvoiceItemDao.
  /// Retorna o ID gerado automaticamente.
  Future<int> insertInvoice(Invoice invoice) {
    return into(
      invoicesRecords,
    ).insert(invoice.toCompanion(), mode: InsertMode.insertOrAbort);
  }

  /// Insere uma nova nota fiscal com seus itens em uma transação.
  ///
  /// Garante que tanto a nota quanto seus itens sejam salvos atomicamente.
  /// Também atualiza o estoque dos produtos vendidos.
  /// Retorna o ID da nota fiscal criada.
  Future<int> insertInvoiceWithItems(Invoice invoice) async {
    return await transaction(() async {
      // Insere a nota fiscal
      final invoiceId = await insertInvoice(invoice);

      // Insere os itens e atualiza estoque
      final invoiceItemDao = db.invoiceItemDao;
      final productDao = db.productDao;

      for (final item in invoice.data.items) {
        await invoiceItemDao.insertInvoiceItem(item, invoiceId: invoiceId);

        // Atualiza o estoque do produto (remove a quantidade vendida)
        await productDao.updateStockQuantity(item.productId, -item.quantity);
      }

      return invoiceId;
    });
  }

  /// Verifica se um número de nota fiscal já existe no banco de dados.
  ///
  /// [invoiceNumber] Número da nota fiscal a ser verificado.
  /// Retorna true se o número já existe, false caso contrário.
  Future<bool> invoiceNumberExists(String invoiceNumber) async {
    final invoice = await getByInvoiceNumber(invoiceNumber);
    return invoice != null;
  }

  /// Atualiza uma nota fiscal existente no banco de dados.
  ///
  /// Nota: Os itens não são atualizados automaticamente.
  /// Use InvoiceItemDao para gerenciar os itens separadamente.
  /// Retorna true se a atualização foi bem-sucedida, false caso contrário.
  Future<bool> updateInvoice(Invoice invoice) async {
    return await update(
      invoicesRecords,
    ).replace(invoice.toCompanion(forUpdate: true));
  }

  /// Atualiza uma nota fiscal e seus itens em uma transação.
  ///
  /// Remove todos os itens existentes e insere os novos.
  /// Retorna true se a atualização foi bem-sucedida, false caso contrário.
  Future<bool> updateInvoiceWithItems(Invoice invoice) async {
    return await transaction(() async {
      // Atualiza a nota fiscal
      final result = await updateInvoice(invoice);

      if (result) {
        // Remove os itens antigos
        final invoiceItemDao = db.invoiceItemDao;
        await invoiceItemDao.deleteByInvoiceId(invoice.id);

        // Insere os novos itens
        for (final item in invoice.data.items) {
          await invoiceItemDao.insertInvoiceItem(item, invoiceId: invoice.id);
        }
      }

      return result;
    });
  }
}
