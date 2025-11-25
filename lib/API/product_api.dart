import "dart:convert";
import "package:http/http.dart" as http;
import "../models/product.dart";

class ProductRepo {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse("https://dummyjson.com/products?limit=300"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List productsJson = data["products"];
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Erreur lors du chargement des produits");
    }
  }

  Future<Product> fetchProductById(int id) async {
    final Uri endpoint = Uri.parse("https://dummyjson.com/products/$id");
    final response = await http.get(endpoint);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Product.fromJson(data);
    } else {
      throw Exception("Oups, il y a eu une erreur");
    }
  }
}
