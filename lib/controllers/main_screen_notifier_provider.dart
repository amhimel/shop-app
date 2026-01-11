import 'package:shop_app/views/shared/export_packages.dart';

class MainScreenNotifierProvider extends ChangeNotifier {
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  set setPageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }
}
