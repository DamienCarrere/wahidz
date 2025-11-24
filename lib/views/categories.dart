import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wahidz/widgets/appbar_widget.dart';
import 'package:wahidz/widgets/bottom_nav_bar.dart';
import 'package:wahidz/widgets/category_product.dart';
import '../view_model/product_vm.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProductViewModel>(context);
    final categories = vm.categories;

    return Scaffold(
      appBar: AppBarWidget("Catégories"),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final productsInCat = vm.productsByCategory(cat);

                  String? imageUrl;
                  if (productsInCat.isNotEmpty) {
                    imageUrl = productsInCat.first.thumbnail;
                  }

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryProduct(category: cat),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: Stack(
                        children: [
                          if (imageUrl != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                imageUrl,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black26,
                            ),
                          ),
                          Center(
                            child: Text(
                              cat[0].toUpperCase() + cat.substring(1),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellowAccent,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
