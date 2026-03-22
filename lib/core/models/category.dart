import 'package:system_loja/core/models/default/default_object.dart';

/// Categoria de produtos (domínio). Serialização em `category_data.dart`.
class Category extends DefaultObject {
  final String name;
  final String? description;

  Category({
    required this.name,
    this.description,
    super.registrationDate,
    super.lastUpdatedDate,
    int? id,
  });
}
