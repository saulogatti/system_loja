import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/category.dart';

part 'category_data.g.dart';

/// JSON para [Category].
@JsonSerializable()
class CategoryData {
  final int id;
  final String name;
  final String? description;
  final DateTime registrationDate;
  final DateTime? lastUpdatedDate;

  const CategoryData({
    required this.id,
    required this.name,
    required this.registrationDate,
    this.description,
    this.lastUpdatedDate,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => _$CategoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDataToJson(this);

  factory CategoryData.fromDomain(Category value) => CategoryData(
    id: value.id,
    name: value.name,
    description: value.description,
    registrationDate: value.registrationDate,
    lastUpdatedDate: value.lastUpdatedDate,
  );

  Category toDomain() => Category(
    id: id,
    name: name,
    description: description,
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );
}
