import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wahidz/view_model/product_vm.dart';
import 'package:wahidz/widgets/appbar_widget.dart';
import 'package:wahidz/widgets/product_card.dart';
import 'package:wahidz/widgets/bottom_nav_bar.dart';
import 'package:wahidz/widgets/promo_carousel.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductViewModel>();

    return Scaffold(
      appBar: AppBarWidget("Home"),

      bottomNavigationBar: BottomNavBar(currentIndex: 1),

      body: body(vm),
    );
  }

  Widget body(ProductViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.error.isNotEmpty) {
      return Center(child: Text(vm.error));
    }

    if (vm.products.isEmpty) {
      return const Center(child: Text("Aucun produit trouvé"));
    }
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        PromoCarousel(products: vm.products),

        const SizedBox(height: 20),

        ...List.generate((vm.products.length / 2).ceil(), (index) {
          final i = index * 2;

          final left = vm.products[i];
          final right = (i + 1 < vm.products.length)
              ? vm.products[i + 1]
              : null;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(child: ProductCard(product: left)),
                const SizedBox(width: 10),
                Expanded(
                  child: right != null
                      ? ProductCard(product: right)
                      : const SizedBox(),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
