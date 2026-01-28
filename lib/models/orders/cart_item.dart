class CartItem {
  final String id;
  final String name;
  final String price;
  final int cartQuantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.cartQuantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      cartQuantity: json['cartQuantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'cartQuantity': cartQuantity,
    };
  }
}
