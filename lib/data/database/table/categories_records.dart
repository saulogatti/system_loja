import 'package:drift/drift.dart';

/// Tabela de categorias de produtos no banco de dados Drift.
///
/// Armazena categorias de forma independente para evitar perda de dados
/// quando produtos são deletados. Produtos referenciam categorias através
/// de chave estrangeira (categoryId).
class CategoriesRecords extends Table {
  /// Descrição opcional da categoria
  TextColumn get description => text().nullable()();

  /// Identificador único da categoria (auto-incrementado)
  IntColumn get id => integer().autoIncrement()();

  /// Data da última atualização
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();

  /// Nome da categoria (obrigatório e único)
  TextColumn get name => text().unique()();

  /// Data de criação do registro
  DateTimeColumn get registrationDate =>
      dateTime().withDefault(currentDateAndTime)();
}
