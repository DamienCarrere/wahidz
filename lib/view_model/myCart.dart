import 'package:flutter/material.dart';
import '../models/product.dart';

bool isLoading = false;

List<Product> myCart = [];

class Mycart extends ChangeNotifier {
  Future<List<Product>> addCart(Product product) async {
    try {
      isLoading = true;
      notifyListeners();

      myCart.add(product);

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
