import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/product.dart';

part 'product_data.g.dart';

/// JSON para [Product].
@JsonSerializable()
class ProductData {
  final int id;
  final String name;
  final String description;
  final double price;
  final int stockQuantity;
  final int? categoryId;
  final String code;
  final DateTime registrationDate;
  final DateTime? lastUpdatedDate;

  const ProductData({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.code,
    required this.registrationDate,
    this.categoryId,
    this.lastUpdatedDate,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => _$ProductDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDataToJson(this);

  factory ProductData.fromDomain(Product value) => ProductData(
    id: value.id,
    name: value.name,
    description: value.description,
    price: value.price,
    stockQuantity: value.stockQuantity,
    categoryId: value.categoryId,
    code: value.code,
    registrationDate: value.registrationDate,
    lastUpdatedDate: value.lastUpdatedDate,
  );

  Product toDomain() => Product(
    id: id,
    name: name,
    description: description,
    price: price,
    stockQuantity: stockQuantity,
    categoryId: categoryId,
    code: code,
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );
}
