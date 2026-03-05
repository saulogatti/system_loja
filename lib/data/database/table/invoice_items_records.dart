import 'package:drift/drift.dart';

/// Tabela para armazenar itens de notas fiscais no Drift.
class InvoiceItemsRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  /// ID da nota fiscal (relacionamento)
  IntColumn get invoiceId => integer().named('nota_id')();
  
  /// ID do produto
  IntColumn get productId => integer().named('produto_id')();
  
  /// Nome do produto (desnormalizado para facilitar consultas)
  TextColumn get productName => text().named('produto_nome')();
  
  /// Código do produto (desnormalizado para facilitar consultas)
  TextColumn get productCode => text().named('produto_codigo')();
  
  /// Quantidade do produto
  IntColumn get quantity => integer().named('quantidade')();
  
  /// Preço unitário
  RealColumn get unitPrice => real().named('preco_unitario')();
  
  /// Valor total (quantidade * preço unitário)
  RealColumn get totalValue => real().named('valor_total')();
}
