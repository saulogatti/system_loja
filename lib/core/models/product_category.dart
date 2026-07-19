import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/product.dart' show Product;

/// Categoria de produtos (domínio). Serialização em `category_data.dart`.
///
/// Agrupa produtos por tipo (ex.: Eletrônicos, Vestuário).
/// Utilizada como chave estrangeira em [Product.categoryId].
class ProductCategory extends DefaultObject {
  ProductCategory({
    required this.name,
    this.description,
    super.registrationDate,
    super.lastUpdatedDate,
    super.id,
  });

  /// Nome da categoria. Deve ser único no sistema.
  final String name;

  /// Descrição opcional da categoria.
  final String? description;
}
