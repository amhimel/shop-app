import '../views/shared/export_packages.dart';

class LoginNotifierProvider extends ChangeNotifier {
  bool _isObscure = true;

  bool get isObscure => _isObscure;

  set isObscure(bool newState) {
    _isObscure = newState;
    notifyListeners();
  }
}
