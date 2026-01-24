import 'dart:convert';

AddToCart addToCartFromJson(String str) => AddToCart.fromJson(json.decode(str));

String addToCartToJson(AddToCart data) => json.encode(data.toJson());

class AddToCart {
  final String cartItem;
  final int quantity;

  AddToCart({
    required this.cartItem,
    required this.quantity,
  });

  factory AddToCart.fromJson(Map<String, dynamic> json) => AddToCart(
    cartItem: json["cartItem"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "cartItem": cartItem,
    "quantity": quantity,
  };
}
