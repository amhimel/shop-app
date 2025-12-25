import 'package:flutter/material.dart';
import 'package:shop_app/views/shared/appstyle.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart Page')),
      body: Center(
        child: Text(
          ' cart page!',
          style: appstyle(24, FontWeight.bold, Colors.black),
        ),
      ),
    );
  }
}
