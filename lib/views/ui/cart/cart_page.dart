import 'dart:developer';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/controllers/payment_notifier_provider.dart';
import 'package:shop_app/services/cart_helper.dart';
import 'package:shop_app/services/payment_helper.dart';
import 'package:shop_app/views/shared/export_files.dart';
import 'package:shop_app/views/shared/export_packages.dart';
import 'package:shop_app/views/ui/payment/payment_webview.dart';
import '../../../models/cart/getCart.dart';
import '../../../models/orders/order_req.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<Product>> _cartList;

  @override
  void initState() {
    _cartList = CartHelper().getCart();
    Future.microtask(() {
      Provider.of<CartProviderNotifier>(context, listen: false).refreshCart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartNotifier = Provider.of<CartProviderNotifier>(context, listen: true);
    var paymentNotifier = Provider.of<PaymentNotifier>(context, listen: true);
    return paymentNotifier.paymentUrl.contains('https')
        ? PaymentWebview()
        : Scaffold(
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
                        child: Consumer<CartProviderNotifier>(
                          builder: (context, cartNotifier, _) {
                            return ListView.builder(
                              itemCount: cartNotifier.cart.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final data = cartNotifier.cart[index];
                                return GestureDetector(
                                  onTap: () {
                                    cartNotifier.productIndex = index;
                                    log(
                                      "index : ${cartNotifier.productIndex = index}",
                                    );
                                    //issert product into checkout list
                                    cartNotifier.checkout.insert(0, data);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      child: Slidable(
                                        key: const ValueKey(0),
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          children: [
                                            // A SlidableAction can have an icon and/or a label.
                                            SlidableAction(
                                              onPressed: (_) async {
                                                await CartHelper()
                                                    .deleteCart(data.id)
                                                    .then((response) {
                                                      if (response == true) {
                                                        log("delete cart item");
                                                        Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                MainScreen(),
                                                          ),
                                                        );
                                                      } else {
                                                        log(
                                                          "Failed to delete cart item",
                                                        );
                                                      }
                                                    });
                                              },
                                              backgroundColor: Color(
                                                0xFF000000,
                                              ),
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              label: 'Delete',
                                            ),
                                          ],
                                        ),
                                        child: Container(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.13,
                                          width: MediaQuery.of(
                                            context,
                                          ).size.width,
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
                                                        padding: EdgeInsets.all(
                                                          10,
                                                        ),
                                                        child:
                                                            CachedNetworkImage(
                                                              imageUrl: data
                                                                  .cartItem
                                                                  .imageUrl[0],
                                                              width: 70,
                                                              height: 70,
                                                              fit: BoxFit.fill,
                                                            ),
                                                      ),
                                                      Positioned(
                                                        top: -4,
                                                        child: GestureDetector(
                                                          onTap: () async {},
                                                          child: SizedBox(
                                                            height: 30.h,
                                                            width: 30.h,
                                                            child: Icon(
                                                              cartNotifier.productIndex ==
                                                                      index
                                                                  ? Feather
                                                                        .check_square
                                                                  : Feather
                                                                        .square,
                                                              color:
                                                                  Colors.black,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: -2,
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            await CartHelper().deleteCart(data.id).then((
                                                              response,
                                                            ) {
                                                              if (response ==
                                                                  true) {
                                                                log(
                                                                  "delete cart item",
                                                                );
                                                                Navigator.pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (
                                                                          context,
                                                                        ) =>
                                                                            MainScreen(),
                                                                  ),
                                                                );
                                                              } else {
                                                                log(
                                                                  "Failed to delete cart item",
                                                                );
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              borderRadius:
                                                                  BorderRadius.only(
                                                                    topRight:
                                                                        Radius.circular(
                                                                          12,
                                                                        ),
                                                                  ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                        0.4,
                                                                      ),
                                                                  offset:
                                                                      const Offset(
                                                                        0,
                                                                        1,
                                                                      ),
                                                                  blurRadius: 8,
                                                                ),
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                        0.05,
                                                                      ),
                                                                  offset:
                                                                      const Offset(
                                                                        1,
                                                                        2,
                                                                      ),
                                                                  blurRadius: 5,
                                                                ),
                                                              ],
                                                            ),
                                                            child: const Center(
                                                              child: Icon(
                                                                Icons
                                                                    .delete_outline,
                                                                color: Colors
                                                                    .white,
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
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          data.cartItem.name,
                                                          style: appstyle(
                                                            16,
                                                            FontWeight.bold,
                                                            Colors.black,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          data
                                                              .cartItem
                                                              .category,
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
                                                              data
                                                                  .cartItem
                                                                  .price,
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
                                                        borderRadius:
                                                            BorderRadius.all(
                                                              Radius.circular(
                                                                16,
                                                              ),
                                                            ),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap:
                                                                cartNotifier
                                                                    .isLoading
                                                                ? null
                                                                : () {
                                                                    cartNotifier
                                                                        .updateQuantity(
                                                                          data.id,
                                                                          "inc",
                                                                        );
                                                                  },
                                                            child: Icon(
                                                              Icons.add_box,
                                                              size: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          cartNotifier.productIndex ==
                                                                  index
                                                              ? cartNotifier
                                                                        .isLoading
                                                                    ? SizedBox(
                                                                        height:
                                                                            16,
                                                                        width:
                                                                            16,
                                                                        child: CircularProgressIndicator(
                                                                          strokeWidth:
                                                                              2,
                                                                        ),
                                                                      )
                                                                    : Text(
                                                                        "${data.quantity}",
                                                                        style: appstyle(
                                                                          12,
                                                                          FontWeight
                                                                              .w600,
                                                                          Colors
                                                                              .black,
                                                                        ),
                                                                      )
                                                              : Text(
                                                                  "${data.quantity}",
                                                                  style: appstyle(
                                                                    12,
                                                                    FontWeight
                                                                        .w600,
                                                                    Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                          InkWell(
                                                            onTap:
                                                                cartNotifier
                                                                    .isLoading
                                                                ? null
                                                                : () {
                                                                    cartNotifier
                                                                        .updateQuantity(
                                                                          data.id,
                                                                          "dec",
                                                                        );
                                                                  },
                                                            child: Icon(
                                                              Icons
                                                                  .indeterminate_check_box_rounded,
                                                              size: 20,
                                                              color:
                                                                  Colors.grey,
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
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  cartNotifier.checkout.isNotEmpty
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: CheckOutButtonWidget(
                            label: "Proceed to Checkout",
                            onTap: () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String? userId = prefs.getString('userId') ?? '';
                              Order model = Order(
                                userId: userId,
                                cartItems: [
                                  CartItem(
                                    id: cartNotifier.checkout[0].cartItem.id,
                                    name:
                                        cartNotifier.checkout[0].cartItem.name,
                                    price:
                                        cartNotifier.checkout[0].cartItem.price,
                                    cartQuantity: 1,
                                  ),
                                ],
                              );
                              //paymentNotifier.paymentUrl
                              PaymentHelper().payment(model).then((value) {
                                paymentNotifier.setPaymentUrl = value;
                                log("payment ${paymentNotifier.paymentUrl}");
                              });
                              //Navigator.pop(context);
                            },
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          );
  }
}
