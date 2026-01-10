import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/cart_provider.dart';
import 'package:shop_app/views/shared/appstyle.dart';
import 'package:shop_app/views/shared/check_out_btn.dart';
import 'package:shop_app/views/ui/mainscreen.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cartNotifier = Provider.of<CartProviderNotifier>(context, listen: true);
    cartNotifier.getCart();
    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close, color: Colors.black),
                ),
                Text(
                  'My Cart',
                  style: appstyle(24, FontWeight.bold, Colors.black),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                    itemCount: cartNotifier.cart.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final data = cartNotifier.cart[index];
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Slidable(
                            key: const ValueKey(0),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: (_) {
                                    cartNotifier.deleteCart(data['key']);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Mainscreen(),
                                      ),
                                    );
                                  },
                                  backgroundColor: Color(0xFF000000),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.13,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade500,
                                    spreadRadius: 5,
                                    blurRadius: 0.3,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(10),
                                            child: CachedNetworkImage(
                                              imageUrl: data['imageUrl'],
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: -2,
                                            child: GestureDetector(
                                              onTap: (){
                                                cartNotifier.deleteCart(
                                                  data['key'],
                                                );
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Mainscreen(),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.only(topRight: Radius.circular(12)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      offset: const Offset(
                                                        0,
                                                        1,
                                                      ),
                                                      blurRadius: 8,
                                                    ),
                                                    BoxShadow(
                                                      color: Colors.white
                                                          .withOpacity(0.05),
                                                      offset: const Offset(
                                                        1,
                                                        2,
                                                      ),
                                                      blurRadius: 5,
                                                    ),
                                                  ],
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 12,
                                          left: 20,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['name'],
                                              style: appstyle(
                                                16,
                                                FontWeight.bold,
                                                Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              data['category'],
                                              style: appstyle(
                                                14,
                                                FontWeight.w600,
                                                Colors.grey,
                                              ),
                                            ),
                                            // SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                Text(
                                                  data['price'],
                                                  style: appstyle(
                                                    18,
                                                    FontWeight.w600,
                                                    Colors.black,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  "size:",
                                                  style: appstyle(
                                                    18,
                                                    FontWeight.w600,
                                                    Colors.black,
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  data['sizes'] != null &&
                                                          data['sizes']
                                                              .isNotEmpty
                                                      ? "${data['sizes'].join(', ')}"
                                                      : "No size",
                                                  style: appstyle(
                                                    18,
                                                    FontWeight.w600,
                                                    Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(16),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: Icon(
                                                  Icons.add_box,
                                                  size: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                data['qty'].toString(),
                                                style: appstyle(
                                                  12,
                                                  FontWeight.w600,
                                                  Colors.black,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Icon(
                                                  Icons
                                                      .indeterminate_check_box_rounded,
                                                  size: 20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CheckOutButtonWidget(
                label: "Proceed to Checkout",
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
