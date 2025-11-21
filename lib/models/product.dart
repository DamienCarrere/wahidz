class Product {
  final int id;
  final String title;
  final String category;
  final num stock;
  final double price;
  final double discountPercentage;
  final String description;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.stock,
    required this.price,
    required this.discountPercentage,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      title: json["title"],
      category: json["category"],
      stock: json["stock"],
      price: (json["price"] as num).toDouble(),
      discountPercentage: (json["discountPercentage"] as num).toDouble(),
      description: json["description"],
    );
  }
}
