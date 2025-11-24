import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wahidz/view_model/myCart.dart';

class Cart extends StatelessWidget {
  Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<MyCart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panier'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: cart.isLoading
          ? const Center(child: CircularProgressIndicator())
          : cart.myCart.isEmpty
          ? const Center(child: Text('Votre panier est vide'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: cart.myCart.length,
              itemBuilder: (context, index) {
                final item = cart.myCart[index];
                final product = item.product;
                final totalPrice = (product.price * item.quantity)
                    .toStringAsFixed(2);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: product.thumbnail.isNotEmpty
                        ? Image.network(
                            product.thumbnail,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.orangeAccent,
                            child: Text(
                              product.title.isNotEmpty ? product.title[0] : '?',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                    title: Text(product.title),
                    subtitle: Text(
                      'Quantité: ${item.quantity} • Prix: \$${totalPrice}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          tooltip: 'Retirer 1',
                          onPressed: () =>
                              cart.removeMycart(product, quantity: 1),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          tooltip: 'Supprimer',
                          onPressed: () => cart.removeMycart(
                            product,
                            quantity: item.quantity,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${cart.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        backgroundColor: Colors.orangeAccent,
        tooltip: 'Retour',
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
