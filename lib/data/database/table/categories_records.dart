import 'package:drift/drift.dart';
import 'package:system_loja/core/models/category.dart';

/// Tabela de categorias de produtos no banco de dados Drift.
///
/// Armazena categorias de forma independente para evitar perda de dados
/// quando produtos são deletados. Produtos referenciam categorias através
/// de chave estrangeira (categoryId).
@UseRowClass(Category)
class CategoriesRecords extends Table {
  /// Identificador único da categoria (auto-incrementado)
  IntColumn get id => integer().autoIncrement()();

  /// Nome da categoria (obrigatório e único)
  TextColumn get name => text().unique()();

  /// Descrição opcional da categoria
  TextColumn get description => text().nullable()();

  /// Data de criação do registro
  DateTimeColumn get registrationDate =>
      dateTime().withDefault(currentDateAndTime)();

  /// Data da última atualização
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
}
