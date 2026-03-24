import 'package:system_loja/core/models/default/default_object.dart';

/// Categoria de produtos (domínio). Serialização em `category_data.dart`.
///
/// Agrupa produtos por tipo (ex.: Eletrônicos, Vestuário).
/// Utilizada como chave estrangeira em [Product.categoryId].
class Category extends DefaultObject {
  /// Nome da categoria. Deve ser único no sistema.
  final String name;

  /// Descrição opcional da categoria.
  final String? description;

  Category({
    required this.name,
    this.description,
    super.registrationDate,
    super.lastUpdatedDate,
    int? id,
  });
}
