import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/auth/login_model.dart';
import 'package:shop_app/models/auth/signup_model.dart';
import 'package:shop_app/services/auth_helper.dart';
import '../views/shared/export_packages.dart';

class LoginNotifierProvider extends ChangeNotifier {
  bool _isObscure = true;

  bool get isObscure => _isObscure;

  set isObscure(bool newState) {
    _isObscure = newState;
    notifyListeners();
  }

  bool _processing = false;

  bool get processing => _processing;

  set processing(bool newState) {
    _processing = newState;
    notifyListeners();
  }

  bool _loginResponse = false;

  bool get loginResponse => _loginResponse;

  set loginResponse(bool newState) {
    _loginResponse = newState;
    notifyListeners();
  }

  bool _responseBool = false;

  bool get responseBool => _responseBool;

  set responseBool(bool newState) {
    _responseBool = newState;
    notifyListeners();
  }

  bool? _loggedIn;

  bool get loggedIn => _loggedIn ?? false;

  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  Future<bool> userLogin(LoginModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    processing = true;
    bool response = await AuthHelper().login(model);
    processing = false;
    responseBool = response;
    loggedIn = prefs.getBool('isLoggedIn') ?? false;
    return response;
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userId");
    prefs.remove("userToken");
    prefs.setBool("isLoggedIn", false);
    loggedIn = prefs.getBool("isLoggedIn") ?? false;
  }

  Future<bool> registerUser(SignUpModel model) async {
    responseBool = await AuthHelper().signUp(model);
    return responseBool;
  }

  getPrefs() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool("isLoggedIn") ?? false;
  }
}
