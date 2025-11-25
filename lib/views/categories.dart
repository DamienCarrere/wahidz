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
      backgroundColor: Colors.white,
      appBar: AppBarWidget("Catégories"),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.85,
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFF131A22),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 55,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(14),
                              ),
                              color: Color(0xFFFFFFFF),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              cat.toUpperCase(),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Color(0xFF232F3E),
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),

                          Expanded(
                            child: imageUrl == null
                                ? const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Colors.black26,
                                      size: 30,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(14),
                                    ),
                                    child: Image.network(
                                      imageUrl,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
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
