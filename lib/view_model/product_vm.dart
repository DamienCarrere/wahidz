import 'package:flutter/material.dart';
import 'package:wahidz/API/product_api.dart';
import 'package:wahidz/models/product.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepo product = ProductRepo();

  List<Product> products = [];

  Product? selectedProduct;

  bool isLoading = false;

  String error = "";

  Future<void> fetchProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      products = await product.fetchProducts();
    } catch (e) {
      error = "Erreur lors du chargement: $e";
      products = [];
    }

    isLoading = false;
    notifyListeners();
  }

  Future<Product?> fetchProductById(int id) async {
    Product? result;
    try {
      isLoading = true;
      notifyListeners();

      result = await product.fetchProductById(id);
      selectedProduct = result;
    } catch (e) {
      error = "Erreur lors du chargement du produit: $e";
      result = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }

    return result;
  }

  List<String> get categories {
    final setCat = <String>{};
    for (var p in products) {
      setCat.add(p.category);
    }
    return setCat.toList();
  }

  List<Product> productsByCategory(String category) {
    return products.where((p) => p.category == category).toList();
  }
}
