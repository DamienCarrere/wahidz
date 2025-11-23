import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wahidz/view_model/product_vm.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProductViewModel>(context);
    final product = vm.selectedProduct;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: vm.isLoading
            ? const CircularProgressIndicator()
            : product == null
            ? const Text('Aucun produit sélectionné')
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product.thumbnail.isNotEmpty)
                      Image.network(
                        product.thumbnail,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    const SizedBox(height: 12),
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Catégorie: ${product.category}'),
                    Text('Prix: \$${product.price.toStringAsFixed(2)}'),
                    Text('Réduction: ${product.discountPercentage}%'),
                    Text('Stock: ${product.stock}'),
                    const SizedBox(height: 8),
                    Text(product.description),
                    const SizedBox(height: 12),
                    if (product.images.isNotEmpty) ...[
                      const Text('Images:'),
                      const SizedBox(height: 8),
                    ],
                  ],
                ),
              ),
      ),
    );
  }
}
