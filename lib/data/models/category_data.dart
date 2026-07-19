import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/product_category.dart';

part 'category_data.g.dart';

/// JSON para [ProductCategory].
@JsonSerializable()
class CategoryData {
  const CategoryData({
    required this.id,
    required this.name,
    required this.registrationDate,
    this.description,
    this.lastUpdatedDate,
  });

  factory CategoryData.fromDomain(ProductCategory value) => CategoryData(
    id: value.id,
    name: value.name,
    description: value.description,
    registrationDate: value.registrationDate,
    lastUpdatedDate: value.lastUpdatedDate,
  );

  factory CategoryData.fromJson(Map<String, dynamic> json) => _$CategoryDataFromJson(json);
  final int id;
  final String name;
  final String? description;
  final DateTime registrationDate;
  final DateTime? lastUpdatedDate;

  ProductCategory toDomain() => ProductCategory(
    id: id,
    name: name,
    description: description,
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );

  Map<String, dynamic> toJson() => _$CategoryDataToJson(this);
}
