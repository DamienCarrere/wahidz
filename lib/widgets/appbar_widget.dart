import 'package:flutter/material.dart';

AppBar AppBarWidget(String title) {
  return AppBar(
    title: Center(
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 28,
        ),
      ),
    ),
    backgroundColor: Color.fromARGB(255, 227, 197, 46),
  );
}
