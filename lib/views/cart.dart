import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("CART")),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text('Home'),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/cart');
              },
              child: Text('Cart'),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/categories');
              },
              child: Text('Categories'),
            ),
          ],
        ),
      ),
    );
  }
}
