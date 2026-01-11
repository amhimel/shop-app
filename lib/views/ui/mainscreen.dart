


import 'package:shop_app/views/shared/export_files.dart';
import 'package:shop_app/views/shared/export_packages.dart';

class Mainscreen extends StatelessWidget {
   Mainscreen({super.key});

  final List<Widget> pageList = [
    const HomePage(),
    const SearchPage(),
    const FavoritesPage(),
    //const CartPage(),
    const ProfilePage(),
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
