import 'package:flutter/material.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class MyCart extends ChangeNotifier {
  bool isLoading = false;

  final List<CartItem> myCart = [];

  Future<List<CartItem>> addCart(Product product, {int quantity = 1}) async {
    try {
      isLoading = true;
      notifyListeners();

      final index = myCart.indexWhere((c) => c.product.id == product.id);
      if (index >= 0) {
        myCart[index].quantity += quantity;
      } else {
        myCart.add(CartItem(product: product, quantity: quantity));
      }

      isLoading = false;
      notifyListeners();

      return myCart;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception(
        "Une erreur est survenue dans l'ajout dans le panier: $e",
      );
    }
  }

  Future<List<CartItem>> removeMycart(
    Product product, {
    int quantity = 1,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final index = myCart.indexWhere((c) => c.product.id == product.id);
      if (index >= 0) {
        final item = myCart[index];
        if (item.quantity > quantity) {
          item.quantity -= quantity;
        } else {
          myCart.removeAt(index);
        }
      }

      isLoading = false;
      notifyListeners();

      return myCart;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception(
        "Une erreur est survenue dans la suppression du panier: $e",
      );
    }
  }

  double get totalPrice =>
      myCart.fold(0.0, (sum, c) => sum + (c.product.price * c.quantity));

  Future<void> clearCart() async {
    try {
      isLoading = true;
      notifyListeners();

      myCart.clear();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception(
        "Une erreur est survenue lors de la suppresion du panier: $e",
      );
    }
  }
}
