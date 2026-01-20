import '../../shared/export_packages.dart';
import '../../shared/export_files.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

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
              text: "Fill in your details to SignUp",
              style: appstyle(18.sp, FontWeight.normal, Colors.white),
            ),
            SizedBox(height: 50.h),
            CustomField(
              hintText: "User Name",
              controller: userNameCtrl,
              keyboard: TextInputType.name,
              validator: (username) {
                if (username!.isEmpty) {
                  return "Please provide a valid username";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 15.h),
            CustomField(
              hintText: "Email",
              controller: emailCtrl,
              keyboard: TextInputType.emailAddress,
              validator: (email) {
                if (email!.isEmpty && !email.contains("@")) {
                  return "Please provide valid email";
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
                  return "Password too weak";
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
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: ReusableText(
                  text: "Login",
                  style: appstyle(14.sp, FontWeight.normal, Colors.white),
                ),
              ),
            ),
            SizedBox(height: 40.h),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 55.h,
                width: 300.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Center(
                  child: ReusableText(
                    text: "REGISTER",
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
