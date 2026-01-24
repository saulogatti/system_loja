import 'package:drift/drift.dart';
import 'package:system_loja/core/models/category.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/table/categories_records.dart';

part 'category_dao.g.dart';

/// DAO para gerenciar operações CRUD de categorias no banco de dados.
///
/// Implementa métodos para criar, ler, atualizar e deletar categorias,
/// além de verificações de duplicidade de nomes.
@DriftAccessor(tables: [CategoriesRecords])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(super.db);

  /// Busca todas as categorias ordenadas por nome.
  ///
  /// Retorna lista de todas as categorias cadastradas.
  Future<List<Category>> getAll() {
    return (select(
      categoriesRecords,
    )..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
  }

  /// Busca uma categoria por ID.
  ///
  /// [id] Identificador único da categoria.
  /// Retorna a categoria encontrada ou null se não existir.
  Future<Category?> getById(int id) {
    return (select(
      categoriesRecords,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Busca uma categoria por nome.
  ///
  /// [name] Nome da categoria a ser buscada.
  /// Retorna a categoria encontrada ou null se não existir.
  Future<Category?> getByName(String name) {
    return (select(
      categoriesRecords,
    )..where((t) => t.name.equals(name))).getSingleOrNull();
  }

  /// Verifica se há produtos associados a uma categoria.
  ///
  /// [categoryId] ID da categoria a ser verificada.
  /// Retorna true se há produtos usando esta categoria.
  Future<bool> hasProducts(int categoryId) async {
    final count =
        await (selectOnly(db.productsRecords)
              ..addColumns([db.productsRecords.id.count()])
              ..where(db.productsRecords.categoryId.equals(categoryId)))
            .getSingle();
    final readCount = count.read(db.productsRecords.id.count());
    return (readCount ?? 0) > 0;
  }

  /// Insere uma nova categoria no banco de dados.
  ///
  /// [name] Nome da categoria (obrigatório e único).
  /// [description] Descrição opcional da categoria.
  /// Retorna o ID da categoria criada.
  Future<int> insertCategory({
    required String name,
    String? description,
  }) async {
    return await into(categoriesRecords).insert(
      CategoriesRecordsCompanion.insert(
        name: name,
        description: Value(description),
      ),
      mode: InsertMode.insertOrAbort,
    );
  }

  /// Verifica se uma categoria com o nome fornecido já existe.
  ///
  /// [name] Nome a ser verificado.
  /// Retorna true se o nome já existe, false caso contrário.
  Future<bool> nameExists(String name) async {
    final category = await getByName(name);
    return category != null;
  }

  /// Remove uma categoria do banco de dados.
  ///
  /// [id] Identificador da categoria a ser removida.
  /// Retorna true se a categoria foi removida com sucesso.
  /// Nota: A exclusão falhará se houver produtos associados (FK constraint).
  Future<bool> remove(int id) async {
    return await (delete(
          categoriesRecords,
        )..where((t) => t.id.equals(id))).go() >
        0;
  }

  /// Atualiza uma categoria existente.
  ///
  /// [id] Identificador da categoria a ser atualizada.
  /// [name] Novo nome da categoria.
  /// [description] Nova descrição da categoria.
  /// Retorna true se a categoria foi atualizada com sucesso.
  Future<bool> updateCategory({
    required int id,
    required String name,
    String? description,
  }) async {
    return await update(categoriesRecords).replace(
      CategoriesRecordsCompanion(
        id: Value(id),
        name: Value(name),
        description: Value(description),
        lastUpdatedDate: Value(DateTime.now()),
      ),
    );
  }
}
