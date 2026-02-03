import 'package:shop_app/services/auth_helper.dart';
import 'package:shop_app/views/shared/export_files.dart';
import 'package:shop_app/views/shared/export_packages.dart' hide Config;
import 'package:shop_app/views/ui/orders/orders_screen.dart';
import 'package:shop_app/views/ui/shipping_address.dart';
import '../../models/auth_response/profile_response_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<ProfileRes> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = AuthHelper().getProfileCached();
  }

  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifierProvider>(context);
    late ProfileRes userData;
    return authNotifier.loggedIn == false
        ? const NonUser()
        : Scaffold(
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
                    height: 80.h,
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
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: ValueListenableBuilder(
                                      valueListenable: Hive.box('userBox').listenable(keys: ['profile']),
                                      builder: (context, box, _) {
                                        final data = box.get('profile');

                                        if (data == null) {
                                          return const CircularProgressIndicator.adaptive();
                                        }

                                        userData = ProfileRes.fromJson(
                                          Map<String, dynamic>.from(data),
                                        );

                                        return Row(
                                          children: [
                                            SizedBox(
                                              width: 35.w,
                                              height: 35.h,
                                              child: CircleAvatar(
                                                backgroundImage: userData.profilePhoto != null
                                                    ? NetworkImage(
                                                  "https://${Config.apiUrl}/${userData.profilePhoto}",
                                                )
                                                    : const AssetImage("assets/images/user.jpg")
                                                as ImageProvider,
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ReusableText(
                                                  text: userData.username ?? "Username",
                                                  style: appstyle(16, FontWeight.normal, Colors.black),
                                                ),
                                                ReusableText(
                                                  text: userData.email ?? "Email",
                                                  style: appstyle(12, FontWeight.normal, Colors.grey.shade600),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),

                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => LoginPage(),
                                    //   ),
                                    // );
                                  },
                                  child: Icon(Feather.edit, size: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 5.h),
                      Container(
                        height: 160.h,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                              title: "My Orders",
                              leading:
                                  MaterialCommunityIcons.truck_fast_outline,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProcessOrders(),
                                  ),
                                );
                              },
                            ),
                            TilesWidget(
                              title: "My Favorites",
                              leading: MaterialCommunityIcons.heart_outline,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FavoritesPage(),
                                  ),
                                );
                              },
                            ),
                            TilesWidget(
                              title: "My Carts",
                              leading: MaterialCommunityIcons.cart_outline,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 10.h),
                      // Container(
                      //   height: 110.h,
                      //   color: Colors.grey.shade200,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       TilesWidget(
                      //         title: "Coupons",
                      //         leading: MaterialCommunityIcons.tag_outline,
                      //         onTap: () {},
                      //       ),
                      //       TilesWidget(
                      //         title: "My Store",
                      //         leading: MaterialCommunityIcons.shopping_outline,
                      //         onTap: () {},
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 10.h),
                      Container(
                        height: 160.h,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                              title: "Shipping address",
                              leading: SimpleLineIcons.location_pin,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShippingAddress(),
                                  ),
                                );
                              },
                            ),
                            TilesWidget(
                              title: "Settings",
                              leading: AntDesign.setting,
                              onTap: () {},
                            ),
                            TilesWidget(
                              title: "Logout",
                              leading: AntDesign.logout,
                              onTap: () {
                                authNotifier.logout();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
