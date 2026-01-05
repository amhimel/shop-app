import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/main_screen_notifier_provider.dart';
import 'package:shop_app/views/shared/bottom_nav.dart';
import 'package:shop_app/views/ui/cart_page.dart';
import 'package:shop_app/views/ui/home_page.dart';
import 'package:shop_app/views/ui/product_by_card.dart';
import 'package:shop_app/views/ui/profile_page.dart';
import 'package:shop_app/views/ui/search_page.dart';

class Mainscreen extends StatelessWidget {
  const Mainscreen({super.key});

  final List<Widget> pageList = const [
    HomePage(),
    SearchPage(),
    HomePage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifierProvider>(
      builder: (context, mainScreenProvider, child) {
        int pageIndex = mainScreenProvider.pageIndex;
        return Scaffold(
          backgroundColor: Color(0xFFE2E2E2),
          body: pageList[pageIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
