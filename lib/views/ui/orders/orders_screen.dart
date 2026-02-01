import 'package:shop_app/services/cart_helper.dart';
import 'package:shop_app/views/shared/export_files.dart';
import 'package:shop_app/views/shared/export_packages.dart';
import '../../../models/orders/order_res.dart';

class ProcessOrders extends StatefulWidget {
  const ProcessOrders({super.key});

  @override
  State<ProcessOrders> createState() => _ProcessOrdersState();
}

class _ProcessOrdersState extends State<ProcessOrders> {
  Future<List<PaidOrders>>? _ordersFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ordersFuture = CartHelper().getOrders();
  }

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
      body: SingleChildScrollView(
        child: Container(
          height: 690.h,
          width: 360.w,
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.all(8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  text: "My Orders",
                  style: appstyle(30, FontWeight.bold, Colors.white),
                ),
                SizedBox(height: 5.h),
                Container(
                  height: 565.h,
                  width: 360.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: FutureBuilder(
                    future: _ordersFuture,
                    builder: (context, snapShot) {
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (snapShot.hasError) {
                        print(
                          'Order Error: ${snapShot.error.toString()}',
                        ); // Debug the error
                        return Center(
                          child: ReusableText(
                            text: "failed to get order.",
                            style: appstyle(14, FontWeight.bold, Colors.red),
                          ),
                        );
                      } else if (!snapShot.hasData) {
                        return Center(
                          child: ReusableText(
                            text: "No cart data found",
                            style: appstyle(14, FontWeight.bold, Colors.black),
                          ),
                        );
                      } else {
                        final orderData = snapShot.data;
                        return ListView.builder(
                          itemCount: orderData!.length,
                          itemBuilder: (context, index) {
                            //log("${orderData.length}");
                            var order = orderData[index];
                            return Container(
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
                                          child: Image.network(
                                            order.product.imageUrl[0],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ReusableText(
                                            text: order.product.name,
                                            style: appstyle(
                                              18,
                                              FontWeight.bold,
                                              Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          FittedBox(
                                            child: ReusableText(
                                              text: order.product.category,
                                              style: appstyle(
                                                12,
                                                FontWeight.w500,
                                                Colors.grey.shade600,
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 3),
                                          ReusableText(
                                            text: "\$${order.product.price}",
                                            style: appstyle(
                                              18,
                                              FontWeight.w600,
                                              Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 30.w,
                                          vertical: 5.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                        ),
                                        child: ReusableText(
                                          text: order.paymentStatus
                                              .toUpperCase(),
                                          style: appstyle(
                                            12,
                                            FontWeight.w600,
                                            Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 5.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              MaterialCommunityIcons
                                                  .truck_fast_outline,
                                              size: 16,
                                            ),
                                            SizedBox(width: 5),
                                            ReusableText(
                                              text: order.deliveryStatus
                                                  .toUpperCase(),
                                              style: appstyle(
                                                12,
                                                FontWeight.normal,
                                                Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
