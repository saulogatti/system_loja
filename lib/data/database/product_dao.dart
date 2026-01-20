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
    return await into(productsRecords).insert(data.toInsertable());
  }

  Future<bool> remove(int id) async {
    return await (delete(productsRecords)..where((t) => t.id.equals(id))).go() >
        0;
  }

  Future<int> updateProduct(Product data) async {
    return await update(productsRecords).replace(data.toInsertable()) ? 1 : 0;
  }
}
