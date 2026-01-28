import 'package:shop_app/models/orders/cart_item.dart';

class Order {
  String userId;
  List<CartItem> cartItems;

  Order({
    required this.userId,
    required this.cartItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      userId: json['userId'],
      cartItems: json['cartItems'] != null
          ? List<CartItem>.from(
        json['cartItems'].map((x) => CartItem.fromJson(x)),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'cartItems':
      cartItems.map((item) => item.toJson()).toList(),
    };
  }
}
