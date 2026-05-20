import 'package:drift/drift.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/mapper/drift_to_domain.dart';
import 'package:system_loja/data/database/table/products_records.dart';

part 'product_dao.g.dart';

/// DAO para gerenciar operações CRUD de produtos no banco de dados Drift.
///
/// Utiliza o padrão Repository e conversões entre [Product] (domínio) e
/// `ProductsRecord` (Drift) via extensões de mapeamento.
@DriftAccessor(tables: [ProductsRecords])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(super.db);

  /// Retorna todos os produtos cadastrados como objetos de domínio [Product].
  Future<List<Product>> getAll() async {
    final rows = await select(productsRecords).get();
    return rows.map((e) => e.toDomain()).toList();
  }

  /// Busca um produto pelo ID.
  ///
  /// Retorna null se o produto não for encontrado.
  Future<Product?> getById(int id) async {
    final row = await (select(
      productsRecords,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row?.toDomain();
  }

  /// Insere um novo produto no banco de dados.
  ///
  /// Usa `insertOrAbort` com `DoNothing` em conflito para evitar duplicatas.
  /// Retorna o ID gerado automaticamente, ou 0 em caso de conflito.
  Future<int> insertProduct(Product data) {
    return into(productsRecords).insert(
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

  /// Remove um produto pelo ID.
  ///
  /// Retorna true se o produto foi removido, false se não encontrado.
  Future<bool> remove(int id) async {
    return await (delete(productsRecords)..where((t) => t.id.equals(id))).go() >
        0;
  }

  /// Atualiza os dados de um produto existente.
  ///
  /// Retorna true se a atualização foi bem-sucedida, false caso contrário.
  Future<bool> updateProduct(Product data) {
    return update(productsRecords).replace(
      ProductsRecordsCompanion(
        id: Value(data.id),
        code: Value(data.code),
        categoryId: Value(data.categoryId),
        description: Value(data.description),
        name: Value(data.name),
        price: Value(data.price),
        stockQuantity: Value(data.stockQuantity),
        lastUpdatedDate: Value(data.lastUpdatedDate),
        registrationDate: Value(data.registrationDate),
      ),
    );
  }

  /// Busca um produto pelo código.
  ///
  /// Retorna o produto encontrado ou null se não existir.
  Future<Product?> getByCode(String code) async {
    final row = await (select(
      productsRecords,
    )..where((t) => t.code.equals(code))).getSingleOrNull();
    return row?.toDomain();
  }

  /// Verifica se um código de produto já existe no banco de dados.
  ///
  /// Retorna true se o código já existe, false caso contrário.
  Future<bool> codeExists(String code) async {
    final product = await getByCode(code);
    return product != null;
  }

  /// Atualiza a quantidade em estoque de um produto.
  ///
  /// [productId] ID do produto a ser atualizado.
  /// [quantityChange] Variação de estoque: positivo para entrada, negativo para saída.
  ///
  /// Retorna true se a atualização foi bem-sucedida, false se o produto não existir.
  /// A validação de estoque negativo fica na camada de domínio ([SalesRepository]).
  Future<bool> updateStockQuantity(int productId, int quantityChange) async {
    final product = await getById(productId);
    if (product == null) return false;

    final newQuantity = product.stockQuantity + quantityChange;

    return update(productsRecords).replace(
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
