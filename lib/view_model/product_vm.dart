import 'package:flutter/material.dart';
import 'package:wahidz/API/product_api.dart';
import 'package:wahidz/models/product.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepo product = ProductRepo();

  List<Product> products = [];

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
}
