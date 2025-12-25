import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BottmNavWidget extends StatelessWidget {
  const BottmNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: 36,
        width: 36,
        child: Icon(Ionicons.home, color: Colors.white),
      ),
    );
  }
}
