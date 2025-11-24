import 'package:flutter/material.dart';
import '../models/product.dart';

class MyCart extends ChangeNotifier {
  bool isLoading = false;

  final List<Product> myCart = [];

  Future<List<Product>> addCart(Product product, {int quantity = 1}) async {
    try {
      isLoading = true;
      notifyListeners();

      for (int i = 0; i < quantity; i++) {
        myCart.add(product);
      }

      isLoading = false;
      notifyListeners();

      return myCart;
    } catch (e) {
      throw Exception(
        "Une erreur est survenue dans l'ajout dans le panier: $e",
      );
    }
  }

  Future<List<Product>> removeMycart(Product product) async {
    try {
      isLoading = true;
      notifyListeners();

      myCart.remove(product);

      isLoading = false;
      notifyListeners();

      return myCart;
    } catch (e) {
      throw Exception(
        "Une erreur est survenue dans la suppression du panier: $e",
      );
    }
  }
}
