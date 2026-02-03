import 'package:shop_app/views/shared/export_files.dart';
import 'package:shop_app/views/shared/export_packages.dart';
import 'package:shop_app/views/shared/loading_effects/shipping_address_loader.dart';

import '../../models/auth_response/profile_response_model.dart';
import '../../services/auth_helper.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  // late Future<ProfileRes> _profileFuture;
  // @override
  // void initState() {
  //   super.initState();
  //   _profileFuture = AuthHelper().getProfile();
  // }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 40.h,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Container(
        height: 690.h,
        width: 360.w,
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                text: "Shipping Address",
                style: appstyle(30, FontWeight.bold, Colors.white),
              ),
              SizedBox(height: 5.h),
              FutureBuilder(
                  future: AuthHelper().getProfile(),
                  builder: (context,snapShot){

                    if (snapShot.connectionState == ConnectionState.waiting) {
                      return ShippingAddressLoader();
                    } else if (snapShot.hasError) {
                      return Center(
                        child: ReusableText(
                          text: "Error Retrieving The Data",
                          style: appstyle(24.sp, FontWeight.bold, Colors.black),
                        ),
                      );
                    } else if (!snapShot.hasData) {
                      return Center(
                        child: ReusableText(
                          text: "Shipping address not found",
                          style: appstyle(24.sp, FontWeight.bold, Colors.black),
                        ),
                      );
                    }else{
                      var data = snapShot.data;
                      return Container(
                          height: 85.h,
                          width: 360.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Container(
                            height: 85.h,
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(SimpleLineIcons.location_pin)
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    SizedBox(
                                      width: 0.62.sw,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: ReusableText(
                                          text: data?.location ?? "",
                                          style: appstyle(
                                            18,
                                            FontWeight.w600,
                                            Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {

                                        },
                                        child: Icon(Feather.edit, size: 18),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          )
                      );
                    }


              })
            ],
          ),
        ),
      ),
    );
  }
}
