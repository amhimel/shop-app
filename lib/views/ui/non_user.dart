import 'package:shop_app/views/shared/export_files.dart';
import '../shared/export_packages.dart';

class NonUser extends StatelessWidget {
  const NonUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE2E2E2),
        elevation: 0,
        leading: Icon(Ionicons.qr_code, size: 18.h, color: Colors.black),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/bng.svg',
                    width: 15.w,
                    height: 25.h,
                  ),
                  SizedBox(width: 5),
                  Container(height: 15.h, width: 1.w, color: Colors.grey),
                  ReusableText(
                    text: " BD",
                    style: appstyle(16, FontWeight.normal, Colors.black),
                  ),
                  SizedBox(width: 10.w),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: const Icon(
                      Ionicons.settings,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 690.h,
              decoration: BoxDecoration(color: Color(0xFFE2E2E2)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 18, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 35.w,
                              height: 35.h,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                  "assets/images/user.jpg",
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: ReusableText(
                                text: "Hello, Please Login Into Your Account ",
                                style: appstyle(
                                  12,
                                  FontWeight.normal,
                                  Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 2),
                            width: 50.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: ReusableText(
                                text: "Login ",
                                style: appstyle(
                                  12,
                                  FontWeight.normal,
                                  Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
