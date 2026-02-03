import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:shop_app/models/auth/signup_model.dart';
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
  TextEditingController locationCtrl = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  bool validation = false;

  void formValidation() {
    validation = emailCtrl.text.isNotEmpty &&
        passwordCtrl.text.isNotEmpty &&
        userNameCtrl.text.isNotEmpty &&
        locationCtrl.text.isNotEmpty;
  }

  Future<void> pickImage() async {
    final XFile? picked =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
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
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close, color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.5,
            image: AssetImage("assets/images/bg.jpg"),
          ),
        ),
        child: ListView(
          children: [
            ReusableText(
              text: "Welcome!",
              style: appstyle(30.sp, FontWeight.w600, Colors.white),
            ),
            ReusableText(
              text: "Fill in your details to SignUp",
              style: appstyle(18.sp, FontWeight.normal, Colors.white),
            ),

            SizedBox(height: 30.h),

            // ---------------- PROFILE IMAGE PICKER ----------------
            Center(
              child: GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  backgroundImage:
                  _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null
                      ? const Icon(Icons.camera_alt, color: Colors.black)
                      : null,
                ),
              ),
            ),

            SizedBox(height: 10.h),
            Center(
              child: ReusableText(
                text: "Tap to upload profile photo",
                style: appstyle(12, FontWeight.normal, Colors.white),
              ),
            ),

            SizedBox(height: 30.h),

            CustomField(
              hintText: "User Name",
              controller: userNameCtrl,
              keyboard: TextInputType.name,
            ),
            SizedBox(height: 15.h),

            CustomField(
              hintText: "Email",
              controller: emailCtrl,
              keyboard: TextInputType.emailAddress,
            ),
            SizedBox(height: 15.h),

            CustomField(
              obscureText: authNotifier.isObscure,
              hintText: "Password",
              controller: passwordCtrl,
              suffixIcon: GestureDetector(
                onTap: () =>
                authNotifier.isObscure = !authNotifier.isObscure,
                child: Icon(
                  authNotifier.isObscure
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              ),
            ),
            SizedBox(height: 15.h),

            CustomField(
              hintText: "Shipping Address",
              controller: locationCtrl,
              keyboard: TextInputType.text,
            ),

            SizedBox(height: 40.h),

            GestureDetector(
              onTap: () {
                formValidation();
                if (!validation) {
                  log("form not valid");
                  return;
                }
                log("IMAGE PATH: ${_profileImage?.path}");
                final model = SignUpModel(
                  username: userNameCtrl.text,
                  email: emailCtrl.text,
                  password: passwordCtrl.text,
                  location: locationCtrl.text,
                  profilePhoto: _profileImage, // 👈 pass image
                );

                authNotifier.registerUser(model).then((response) {
                  if (response) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                    );
                  }
                });
              },
              child: Container(
                height: 55.h,
                width: 300.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: const Center(
                  child: Text(
                    "REGISTER",
                    style: TextStyle(color: Colors.black, fontSize: 18),
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
