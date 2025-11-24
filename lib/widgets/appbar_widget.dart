import 'package:flutter/material.dart';

AppBar AppBarWidget(String title) {
  return AppBar(
    title: Center(child: Text(title)),
    backgroundColor: Colors.orangeAccent,
  );
}
