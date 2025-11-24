import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wahidz/view_model/product_vm.dart';
import 'package:wahidz/view_model/myCart.dart';
import 'package:wahidz/widgets/bottom_nav_bar.dart';
import 'package:wahidz/view_model/myCart.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool load = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!load) {
      load = true;

      final int id = ModalRoute.of(context)!.settings.arguments as int;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        Provider.of<ProductViewModel>(
          context,
          listen: false,
        ).fetchProductById(id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProductViewModel>(context);
    final product = vm.selectedProduct;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Home")),
        backgroundColor: Colors.orangeAccent,
      ),

      bottomNavigationBar: BottomNavBar(currentIndex: 1),
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
                    ElevatedButton(
                      onPressed: () async {
                        await Provider.of<MyCart>(
                          context,
                          listen: false,
                        ).addCart(product);
                        Navigator.pushNamed(context, '/cart');
                      },
                      child: const Text('Ajouter au panier'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
