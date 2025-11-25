import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/categories');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Color.fromARGB(255, 227, 197, 46),
      selectedLabelStyle: const TextStyle(fontFamily: 'Poppins'),
      unselectedLabelStyle: const TextStyle(fontFamily: 'Poppins'),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Catégories"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: "Panier",
        ),
      ],
      onTap: (index) => _onItemTapped(context, index),
    );
  }
}
