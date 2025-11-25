import 'package:flutter/material.dart';
import 'package:wahidz/API/product_api.dart';
import 'package:wahidz/models/product.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepo product = ProductRepo();

  List<Product> products = [];

  Product? selectedProduct;

  int selectedQuantity = 1;
  int selectedImageIndex = 0;

  int get maxQuantity =>
      selectedProduct != null ? selectedProduct!.stock.toInt() : 9999;

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
      selectedQuantity = 1;
      selectedImageIndex = 0;
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

  void incrementQuantity() {
    if (selectedProduct == null) return;
    if (selectedQuantity < maxQuantity) {
      selectedQuantity += 1;
      notifyListeners();
    }
  }

  void decrementQuantity() {
    if (selectedQuantity > 1) {
      selectedQuantity -= 1;
      notifyListeners();
    }
  }

  void setImageIndex(int index) {
    if (selectedProduct == null) return;
    if (index < 0) index = 0;
    final last = selectedProduct!.images.length - 1;
    if (index > last) index = last;
    selectedImageIndex = index;
    notifyListeners();
  }
}
