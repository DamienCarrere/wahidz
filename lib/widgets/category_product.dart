import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wahidz/widgets/appbar_widget.dart';
import 'package:wahidz/widgets/bottom_nav_bar.dart';
import '../view_model/product_vm.dart';
import '../widgets/product_card.dart';

class CategoryProduct extends StatelessWidget {
  final String category;

  const CategoryProduct({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProductViewModel>(context);
    final items = vm.productsByCategory(category);

    return Scaffold(
      appBar: AppBarWidget(category),

      bottomNavigationBar: BottomNavBar(currentIndex: 0),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ProductCard(product: items[index]);
        },
      ),
    );
  }
}
