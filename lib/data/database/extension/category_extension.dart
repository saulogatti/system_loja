import 'package:drift/drift.dart';
import 'package:system_loja/core/models/category.dart';
import 'package:system_loja/data/database/table/categories_records.dart';

/// Extensão para converter CategoriesRecord em Category (modelo de domínio).
extension CategoryFromData on CategoriesRecord {
  /// Converte um registro Drift em modelo de domínio Category.
  Category toDomain() {
    return Category(
      id: id,
      name: name,
      description: description,
      lastUpdatedDate: lastUpdatedDate,
    );
  }
}

/// Extensão para converter Category em CategoriesRecordsCompanion (Drift).
extension CategoryToCompanion on Category {
  /// Converte modelo de domínio Category em Companion para inserção/atualização.
  ///
  /// [forUpdate] Se true, inclui o ID para operações de atualização.
  CategoriesRecordsCompanion toCompanion({bool forUpdate = false}) {
    if (forUpdate) {
      return CategoriesRecordsCompanion(
        id: Value(id),
        name: Value(name),
        description: Value(description),
        lastUpdatedDate: Value(DateTime.now()),
      );
    }
    return CategoriesRecordsCompanion.insert(
      name: name,
      description: Value(description),
    );
  }
}
