import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wahidz/view_model/product_vm.dart';
import 'package:wahidz/widgets/bottom_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final productVM = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("HOME")),
        backgroundColor: Colors.orangeAccent,
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}
