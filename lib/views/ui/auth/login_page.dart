import 'dart:developer';
import 'package:shop_app/models/auth/login_model.dart';
import 'package:shop_app/views/shared/export_files.dart';
import '../../shared/export_packages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  bool validation = false;

  void formValidation() {
    if (emailCtrl.text.isNotEmpty && passwordCtrl.text.isNotEmpty) {
      validation = true;
    } else {
      validation = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifierProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        toolbarHeight: 50.h,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(AntDesign.close, size: 18, color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.5,
            image: AssetImage("assets/images/bg.jpg"),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ReusableText(
              text: "Welcome!",
              style: appstyle(30.sp, FontWeight.w600, Colors.white),
            ),
            ReusableText(
              text: "Fill in your details to login",
              style: appstyle(18.sp, FontWeight.normal, Colors.white),
            ),
            SizedBox(height: 50.h),
            CustomField(
              hintText: "Email",
              controller: emailCtrl,
              keyboard: TextInputType.emailAddress,
              validator: (email) {
                if (email!.isEmpty && !email.contains("@")) {
                  return "Please Provide valid email";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 15.h),
            CustomField(
              obscureText: authNotifier.isObscure,
              hintText: "Password",
              controller: passwordCtrl,
              suffixIcon: GestureDetector(
                onTap: () {
                  authNotifier.isObscure = !authNotifier.isObscure;
                },
                child: authNotifier.isObscure
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              ),
              validator: (password) {
                if (password!.isEmpty && password.length < 7) {
                  return "Password Too Weak";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: ReusableText(
                  text: "Register",
                  style: appstyle(14.sp, FontWeight.normal, Colors.white),
                ),
              ),
            ),
            SizedBox(height: 40.h),
            GestureDetector(
              onTap: () {
                formValidation();
                if (validation) {
                  LoginModel loginModel = LoginModel(
                    email: emailCtrl.text.trim(),
                    password: passwordCtrl.text.trim(),
                  );
                  authNotifier.userLogin(loginModel).then((response) {
                    if (response == true) {
                      log("logged in ");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    } else {
                      log("Failed to login. Response: $response");
                    }
                  });
                } else {
                  log("form not validated.");
                }
              },
              child: Container(
                height: 55.h,
                width: 300.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Center(
                  child: ReusableText(
                    text: "LOGIN",
                    style: appstyle(18.sp, FontWeight.normal, Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
