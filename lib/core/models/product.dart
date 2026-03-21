import 'package:system_loja/core/models/default/default_object.dart';

/// Produto (domínio). Serialização em `product_data.dart`.
class Product extends DefaultObject {
  final String name;
  final String description;
  final double price;
  final int stockQuantity;

  /// ID da categoria (FK para `categories_records`).
  final int? categoryId;
  final String code;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.code,
    super.registrationDate,
    super.lastUpdatedDate,
    this.categoryId,
    int? id,
  });
}
