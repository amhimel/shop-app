import 'package:shop_app/models/cart/getCart.dart';
import 'package:shop_app/views/shared/export_packages.dart';

class CartProviderNotifier extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    if (_counter >= 1) {
      _counter--;
      notifyListeners();
    }
  }

  //get index for checkout
  int? _productIndex;

  int get productIndex => _productIndex ?? 0;

  set productIndex(int newProductIndexState) {
    _productIndex = newProductIndexState;
    notifyListeners();
  }

  //checkout work
  List<Product> _checkout = [];

  List<Product> get checkout => _checkout;

  set checkout(List<Product> newState) {
    _checkout = newState;
    notifyListeners();
  }

  // List<dynamic> _cart = [];
  // final _cartBox = Hive.box('cart_box');

  //List<dynamic> get cart => _cart;

  // set cart(List<dynamic> newCart) {
  //   _cart = newCart;
  // }

  // getCart() {
  //   final cartData = _cartBox.keys.map((key) {
  //     final item = _cartBox.get(key);
  //     print("Hive item: $item");
  //     print("Hive item sizes: ${item['sizes']}");
  //     return {
  //       "key": key,
  //       "id": item['id'],
  //       "name": item['name'],
  //       "category": item['category'],
  //       "sizes": item['sizes'],
  //       "imageUrl": item['imageUrl'],
  //       "price": item['price'],
  //       "qty": item['qty'],
  //     };
  //   }).toList();
  //
  //   _cart = cartData.reversed.toList();
  // }
  //
  // Future<void> deleteCart(int key) async {
  //   await _cartBox.delete(key);
  // }
  //
  // // hive for local DB create cart
  // Future<void> createCart(Map<String, dynamic> newCart) async {
  //   await _cartBox.add(newCart);
  // }
}
