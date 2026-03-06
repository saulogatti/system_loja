import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends DefaultObject {
  final String name;
  final String description;
  final double price;
  final int stockQuantity;

  /// ID da categoria à qual o produto pertence (referência FK para categories_records)
  final int? categoryId;
  final String code;
  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.code,
    super.lastUpdatedDate,
    this.categoryId,
    int? id,
  }) : super(id: id ?? -1);
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
