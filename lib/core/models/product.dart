import 'package:system_loja/core/models/default/default_object.dart';

/// Produto (domínio). Serialização em `product_data.dart`.
///
/// Representa um item do catálogo da loja com preço, estoque e código único.
class Product extends DefaultObject {
  /// Nome do produto.
  final String name;

  /// Descrição detalhada do produto.
  final String description;

  /// Preço de venda unitário.
  final double price;

  /// Quantidade disponível em estoque.
  final int stockQuantity;

  /// ID da categoria (FK para `categories_records`). Pode ser nulo.
  final int? categoryId;

  /// Código único do produto (ex.: PRD-20260123-0001).
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
    super.id,
  });
}
