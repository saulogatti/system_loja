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
  final String category;
  final String code;
  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    super.lastUpdatedDate,
    required this.category,
    required this.code,
    int? id,
  }) : super(id: id ?? -1);
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  @override
  Map<String, dynamic> toJson() {
    return _$ProductToJson(this);
  }
}
