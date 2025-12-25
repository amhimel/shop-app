import 'package:flutter/material.dart';
import 'package:shop_app/views/shared/appstyle.dart';
import 'package:shop_app/views/shared/bottom_nav_widget.dart';

class Mainscreen extends StatelessWidget {
  const Mainscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BottmNavWidget(),
                const BottmNavWidget(),
                const BottmNavWidget(),
                const BottmNavWidget(),
                const BottmNavWidget(),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Main Screen!',
          style: appstyle(24, FontWeight.bold, Colors.black),
        ),
      ),
    );
  }
}
