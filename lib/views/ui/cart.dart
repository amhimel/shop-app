import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/views/shared/appstyle.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final _cartBox = Hive.box('cart_box');

  @override
  Widget build(BuildContext context) {
    List<dynamic> cart = [];
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      print("Hive item: $item");
      print("Hive item sizes: ${item['sizes']}");
      return {
        "key": key,
        "id": item['id'],
        "name": item['name'],
        "category": item['category'],
        "sizes": item['sizes'],
        "imageUrl": item['imageUrl'],
        "price": item['price'],
        "qty": item['qty'],
      };
    }).toList();

    cart = cartData.reversed.toList();

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
                    itemCount: cart.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final data = cart[index];
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
                                    _cartBox.delete(data['key']);
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
                                      Padding(
                                        padding: EdgeInsets.all(12),
                                        child: CachedNetworkImage(
                                          imageUrl: data['imageUrl'],
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.fill,
                                        ),
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
          ],
        ),
      ),
    );
  }
}
