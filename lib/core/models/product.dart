class Product {
  final String name;
  final String description;
  final double price;
  final int stockQuantity;
  final DateTime? lastUpdatedDate;
  final DateTime registrationDate;
  final String category;
  final String code;
  int id;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    this.lastUpdatedDate,
    required this.category,
    required this.code,
  }) : registrationDate = DateTime.now();
}
