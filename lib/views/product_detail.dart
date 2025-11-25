import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wahidz/view_model/product_vm.dart';
import 'package:wahidz/view_model/myCart.dart';
import 'package:wahidz/widgets/appbar_widget.dart';
import 'package:wahidz/widgets/bottom_nav_bar.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isLoading) {
      isLoading = true;

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
    final productViewModel = Provider.of<ProductViewModel>(context);
    final selectedProduct = productViewModel.selectedProduct;

    return Scaffold(
      appBar: AppBarWidget("Détail"),

      bottomNavigationBar: BottomNavBar(currentIndex: 1),
      body: productViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : selectedProduct == null
          ? const Center(child: Text('Aucun produit sélectionné'))
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 320,
                          child: Column(
                            children: [
                              Expanded(
                                child: PageView.builder(
                                  itemCount: selectedProduct.images.length,
                                  onPageChanged: (pageIndex) =>
                                      productViewModel.setImageIndex(pageIndex),
                                  itemBuilder: (context, imageIndex) {
                                    final url =
                                        selectedProduct.images[imageIndex];
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        url,
                                        fit: BoxFit.contain,
                                        width: double.infinity,
                                        loadingBuilder:
                                            (context, child, progress) {
                                              if (progress == null)
                                                return child;
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                        errorBuilder: (context, error, stack) =>
                                            const Center(
                                              child: Icon(Icons.broken_image),
                                            ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  selectedProduct.images.length,
                                  (dotIndex) => Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    width:
                                        productViewModel.selectedImageIndex ==
                                            dotIndex
                                        ? 26
                                        : 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color:
                                          productViewModel.selectedImageIndex ==
                                              dotIndex
                                          ? Colors.deepPurple
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          selectedProduct.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedProduct.category,
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            Text(
                              'Stock: ${selectedProduct.stock}',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${(selectedProduct.price * (1 - selectedProduct.discountPercentage / 100)).toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (selectedProduct.discountPercentage > 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\$${selectedProduct.price.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '${selectedProduct.discountPercentage}% de réduction',
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Text(
                          selectedProduct.description,
                          textAlign: TextAlign.justify,
                        ),

                        const SizedBox(height: 20),

                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Quantité:',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed:
                                          productViewModel.selectedQuantity > 1
                                          ? () => productViewModel
                                                .decrementQuantity()
                                          : null,
                                      icon: const Icon(Icons.remove),
                                    ),
                                    SizedBox(
                                      width: 40,
                                      child: Center(
                                        child: Text(
                                          '${productViewModel.selectedQuantity}',
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed:
                                          productViewModel.selectedQuantity <
                                              productViewModel.maxQuantity
                                          ? () => productViewModel
                                                .incrementQuantity()
                                          : null,
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                'Max: ${productViewModel.maxQuantity}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await Provider.of<MyCart>(
                                    context,
                                    listen: false,
                                  ).addCart(
                                    selectedProduct,
                                    quantity: productViewModel.selectedQuantity,
                                  );
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${productViewModel.selectedQuantity} × "${selectedProduct.title}" ajouté au panier',
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(
                                    255,
                                    227,
                                    197,
                                    46,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                                child: const Text(
                                  'Ajouter au panier',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
