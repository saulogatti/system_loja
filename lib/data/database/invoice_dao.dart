import 'package:drift/drift.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/extension/invoice_to_companion.dart';
import 'package:system_loja/data/database/invoice_item_dao.dart';
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
    final invoiceItemDao = InvoiceItemDao(db);
    
    final invoices = <Invoice>[];
    for (final record in records) {
      final items = await invoiceItemDao.getByInvoiceId(record.id);
      invoices.add(record.toDomain(items));
    }
    return invoices;
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
    
    final invoiceItemDao = InvoiceItemDao(db);
    final items = await invoiceItemDao.getByInvoiceId(record.id);
    return record.toDomain(items);
  }

  /// Insere uma nova nota fiscal no banco de dados.
  ///
  /// Aceita um objeto Invoice do domínio e o converte para Companion.
  /// Os itens da nota devem ser inseridos separadamente usando InvoiceItemDao.
  /// Retorna o ID gerado automaticamente.
  Future<int> insertInvoice(Invoice invoice) {
    return into(invoicesRecords).insert(invoice.toCompanion());
  }

  /// Insere uma nova nota fiscal com seus itens em uma transação.
  ///
  /// Garante que tanto a nota quanto seus itens sejam salvos atomicamente.
  /// Retorna o ID da nota fiscal criada.
  Future<int> insertInvoiceWithItems(Invoice invoice) async {
    return await transaction(() async {
      // Insere a nota fiscal
      final invoiceId = await insertInvoice(invoice);
      
      // Insere os itens
      final invoiceItemDao = InvoiceItemDao(db);
      for (final item in invoice.data.items) {
        await invoiceItemDao.insertInvoiceItem(item, invoiceId: invoiceId);
      }
      
      return invoiceId;
    });
  }

  /// Atualiza uma nota fiscal existente no banco de dados.
  ///
  /// Nota: Os itens não são atualizados automaticamente.
  /// Use InvoiceItemDao para gerenciar os itens separadamente.
  /// Retorna 1 se a atualização foi bem-sucedida, 0 caso contrário.
  Future<int> updateInvoice(Invoice invoice) async {
    return await update(invoicesRecords).replace(invoice.toCompanion(forUpdate: true)) ? 1 : 0;
  }

  /// Atualiza uma nota fiscal e seus itens em uma transação.
  ///
  /// Remove todos os itens existentes e insere os novos.
  /// Retorna 1 se a atualização foi bem-sucedida, 0 caso contrário.
  Future<int> updateInvoiceWithItems(Invoice invoice) async {
    return await transaction(() async {
      // Atualiza a nota fiscal
      final result = await updateInvoice(invoice);
      
      if (result > 0) {
        // Remove os itens antigos
        final invoiceItemDao = InvoiceItemDao(db);
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
