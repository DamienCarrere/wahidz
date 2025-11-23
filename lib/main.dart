import 'package:flutter/material.dart';
import 'package:wahidz/view_model/product_vm.dart';
import 'package:wahidz/views/cart.dart';
import 'package:wahidz/views/categories.dart';
import 'package:wahidz/views/home.dart';
import 'package:wahidz/views/product.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductViewModel()..fetchProducts(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/product': (context) => const Product(),
        '/cart': (context) => const Cart(),
        '/categories': (context) => const Categories(),
      },
      title: 'Wahidz',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
