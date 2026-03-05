import 'package:drift/drift.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/extension/invoice_to_companion.dart';
import 'package:system_loja/data/database/table/invoice_items_records.dart';

part 'invoice_item_dao.g.dart';

/// DAO para gerenciar operações CRUD de itens de notas fiscais no banco de dados Drift.
///
/// Utiliza o padrão Repository e conversões entre InvoiceItem (domínio) e
/// InvoiceItemsRecord (Drift) através de extensões.
@DriftAccessor(tables: [InvoiceItemsRecords])
class InvoiceItemDao extends DatabaseAccessor<AppDatabase>
    with _$InvoiceItemDaoMixin {
  InvoiceItemDao(super.db);

  /// Remove um item de nota fiscal do banco de dados pelo ID.
  ///
  /// Retorna o número de linhas afetadas (normalmente 1 ou 0).
  Future<int> deleteInvoiceItem(int id) {
    return (delete(invoiceItemsRecords)..where((t) => t.id.equals(id))).go();
  }

  /// Remove todos os itens de uma nota fiscal específica.
  ///
  /// Útil ao atualizar uma nota fiscal com novos itens.
  /// Retorna o número de linhas removidas.
  Future<int> deleteByInvoiceId(int invoiceId) {
    return (delete(invoiceItemsRecords)
          ..where((t) => t.invoiceId.equals(invoiceId)))
        .go();
  }

  /// Retorna todos os itens de notas fiscais como objetos de domínio InvoiceItem.
  Future<List<InvoiceItem>> getAll() async {
    final records = await select(invoiceItemsRecords).get();
    return records.map((record) => record.toDomain()).toList();
  }

  /// Busca um item de nota fiscal pelo ID.
  ///
  /// Retorna null se o item não for encontrado.
  Future<InvoiceItem?> getById(int id) async {
    final record = await (select(
      invoiceItemsRecords,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return record?.toDomain();
  }

  /// Retorna todos os itens de uma nota fiscal específica.
  ///
  /// Usado para carregar os itens ao buscar uma nota fiscal completa.
  Future<List<InvoiceItem>> getByInvoiceId(int invoiceId) async {
    final records = await (select(invoiceItemsRecords)
          ..where((t) => t.invoiceId.equals(invoiceId)))
        .get();
    return records.map((record) => record.toDomain()).toList();
  }

  /// Insere um novo item de nota fiscal no banco de dados.
  ///
  /// Aceita um objeto InvoiceItem do domínio e o ID da nota fiscal.
  /// Retorna o ID gerado automaticamente.
  Future<int> insertInvoiceItem(
    InvoiceItem item, {
    required int invoiceId,
  }) {
    return into(invoiceItemsRecords)
        .insert(item.toCompanion(invoiceId: invoiceId), mode: InsertMode.insertOrReplace);
  }
}
