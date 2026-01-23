import 'package:drift/drift.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/table/products_records.dart';

part 'product_dao.g.dart';

@DriftAccessor(tables: [ProductsRecords])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(super.db);

  Future<List<Product>> getAll() {
    return select(productsRecords).get();
  }

  Future<Product?> getById(int id) {
    return (select(
      productsRecords,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertProduct(Product data) async {
    return await into(productsRecords).insert(
      ProductsRecordsCompanion.insert(
        code: data.code,
        category: data.category,
        description: data.description,
        name: data.name,
        price: data.price,
        stockQuantity: data.stockQuantity,
      ),
      mode: InsertMode.insertOrAbort, onConflict: DoNothing(),
    );
  }

  Future<bool> remove(int id) async {
    return await (delete(productsRecords)..where((t) => t.id.equals(id))).go() >
        0;
  }

  Future<bool> updateProduct(Product data) async {
    return await update(productsRecords).replace(
      ProductsRecordsCompanion(
        id: Value(data.id),
        code: Value(data.code),
        category: Value(data.category),
        description: Value(data.description),
        name: Value(data.name),
        price: Value(data.price),
        stockQuantity: Value(data.stockQuantity),
        lastUpdatedDate: Value(data.lastUpdatedDate),
      ),
    );
  }

  /// Busca um produto pelo código.
  ///
  /// [code] Código do produto a ser buscado.
  /// Retorna o produto encontrado ou null se não existir.
  Future<Product?> getByCode(String code) {
    return (select(
      productsRecords,
    )..where((t) => t.code.equals(code))).getSingleOrNull();
  }

  /// Verifica se um código de produto já existe no banco de dados.
  ///
  /// [code] Código a ser verificado.
  /// Retorna true se o código já existe, false caso contrário.
  Future<bool> codeExists(String code) async {
    final product = await getByCode(code);
    return product != null;
  }
}
