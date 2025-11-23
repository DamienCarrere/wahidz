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
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Product")),
        backgroundColor: Colors.orangeAccent,
      ),
      body: const Center(child: Text('Product')),
    );
  }
}
