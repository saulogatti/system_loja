import 'package:drift/drift.dart';

/// Tabela Drift de categorias de produto no [AppDatabase].
///
/// {@category persistencia}
/// {@subCategory Cadastros}
///
/// Categorias independentes dos produtos; a FK fica em [ProductsRecords].
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
