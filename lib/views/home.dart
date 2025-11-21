import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("HOME")),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              },
              child: Text('Home'),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/cart');
              },
              child: Text('Cart'),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/categories');
              },
              child: Text('Categories'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/categories');
              },
            ),
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/cart');
              },
            ),
          ],
        ),
      ),
    );
  }
}
