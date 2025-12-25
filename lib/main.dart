import 'package:flutter/material.dart';
import 'package:shop_app/ui/mainscreen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Shop App',
      home: const Mainscreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
