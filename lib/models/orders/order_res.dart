import '../cart/getCart.dart' show ProductItem;

class PaidOrders {
  final String id;
  final String userId;
  final ProductItem product;
  final int quantity;
  final double subtotal;
  final double total;
  final String deliveryStatus;
  final String paymentStatus;

  PaidOrders({
    required this.id,
    required this.userId,
    required this.product,
    required this.quantity,
    required this.subtotal,
    required this.total,
    required this.deliveryStatus,
    required this.paymentStatus,
  });

  factory PaidOrders.fromJson(Map<String, dynamic> json) {
    return PaidOrders(
      id: json['_id'],
      userId: json['userId'],
      product: ProductItem.fromJson(json['productId']),
      quantity: json['quantity'],
      subtotal: (json['subtotal'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      deliveryStatus: json['delivery_status'],
      paymentStatus: json['payment_status'],
    );
  }
}
