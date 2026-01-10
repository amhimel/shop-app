import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/main_screen_notifier_provider.dart';
import 'package:shop_app/views/shared/bottom_nav_widget.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifierProvider>(
      builder: (context, mainScreenProvider, child) {
        return SafeArea(
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
                  BottmNavWidget(
                    onTap: () {
                      mainScreenProvider.setPageIndex = 0;
                    },
                    icon: mainScreenProvider.pageIndex == 0
                        ? Ionicons.home
                        : Ionicons.home_outline,
                  ),
                  BottmNavWidget(
                    onTap: () {
                      mainScreenProvider.setPageIndex = 1;
                    },
                    icon: mainScreenProvider.pageIndex == 1
                        ? Ionicons.search
                        : Ionicons.search_outline,
                  ),
                  BottmNavWidget(
                    onTap: () {
                      mainScreenProvider.setPageIndex = 2;
                    },
                    icon: mainScreenProvider.pageIndex == 2
                        ? Ionicons.heart
                        : Ionicons.heart_outline,
                  ),
                  BottmNavWidget(
                    onTap: () {
                      mainScreenProvider.setPageIndex = 3;
                    },
                    icon: mainScreenProvider.pageIndex == 3
                        ? Ionicons.cart
                        : Ionicons.cart_outline,
                  ),
                  BottmNavWidget(
                    onTap: () {
                      mainScreenProvider.setPageIndex = 4;
                    },
                    icon: mainScreenProvider.pageIndex == 4
                        ? Ionicons.person
                        : Ionicons.person_outline,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
