import "dart:convert";
import "package:http/http.dart" as http;
import "../models/product.dart";

class ProductRepo {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse("https://dummyjson.com/products?limit=15"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List productsJson = data["products"];
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Erreur lors du chargement des produits");
    }
  }
}
