import 'package:flutter/material.dart';
import 'package:wahidz/view_model/myCart.dart';
import 'package:wahidz/view_model/product_vm.dart';
import 'package:wahidz/views/cart.dart';
import 'package:wahidz/views/categories.dart';
import 'package:wahidz/views/home.dart';
import 'package:wahidz/views/product_detail.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductViewModel()..fetchProducts(),
        ),
        ChangeNotifierProvider(create: (_) => MyCart()),
      ],
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
        '/product_detail': (context) => const ProductDetail(),
        '/cart': (context) => Cart(),
        '/categories': (context) => const Categories(),
      },
      title: 'Wahidz',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
