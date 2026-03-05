import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';

part 'category.g.dart';

/// Modelo de domínio para categorias de produtos.
///
/// Representa uma categoria que pode ser associada a múltiplos produtos.
/// Categorias são gerenciadas de forma independente na tabela categories_records
/// e referenciadas pelos produtos através de categoryId.
@JsonSerializable()
class Category extends DefaultObject {
  /// Nome da categoria
  final String name;

  /// Descrição opcional da categoria
  final String? description;

  Category({
    required this.name,
    this.description,
    super.lastUpdatedDate,
    int? id,
  }) : super(id: id ?? -1);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return _$CategoryToJson(this);
  }
}
