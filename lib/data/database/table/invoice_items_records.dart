import 'package:drift/drift.dart';

/// Tabela Drift de itens de nota fiscal no [AppDatabase].
///
/// {@category persistencia}
/// {@subCategory Vendas}
class InvoiceItemsRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// ID da nota fiscal (relacionamento)
  IntColumn get invoiceId => integer()();

  /// Código do produto (desnormalizado para facilitar consultas)
  TextColumn get productCode => text()();

  /// ID do produto
  IntColumn get productId => integer()();

  /// Nome do produto (desnormalizado para facilitar consultas)
  TextColumn get productName => text()();

  /// Quantidade do produto
  IntColumn get quantity => integer()();

  /// Valor total (quantidade * preço unitário)
  RealColumn get totalValue => real()();

  /// Preço unitário
  RealColumn get unitPrice => real()();
}
