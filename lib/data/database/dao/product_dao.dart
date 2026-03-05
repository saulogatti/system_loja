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
        categoryId: Value(data.categoryId),
        description: data.description,
        name: data.name,
        price: data.price,
        stockQuantity: data.stockQuantity,
      ),
      mode: InsertMode.insertOrAbort,
      onConflict: DoNothing(),
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
        categoryId: Value(data.categoryId),
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

  /// Atualiza a quantidade em estoque de um produto.
  ///
  /// [productId] ID do produto a ser atualizado.
  /// [quantityChange] Quantidade a ser adicionada (positivo) ou removida (negativo).
  /// Retorna true se a atualização foi bem-sucedida, false caso contrário.
  Future<bool> updateStockQuantity(int productId, int quantityChange) async {
    final product = await getById(productId);
    if (product == null) return false;

    final newQuantity = product.stockQuantity + quantityChange;
    if (newQuantity < 0) return false;

    return await update(productsRecords).replace(
      ProductsRecordsCompanion(
        id: Value(productId),
        code: Value(product.code),
        categoryId: Value(product.categoryId),
        description: Value(product.description),
        name: Value(product.name),
        price: Value(product.price),
        stockQuantity: Value(newQuantity),
        lastUpdatedDate: Value(DateTime.now()),
      ),
    );
  }
}
