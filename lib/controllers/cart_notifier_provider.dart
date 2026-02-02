import 'package:shop_app/models/cart/getCart.dart';
import 'package:shop_app/views/shared/export_packages.dart';

import '../services/cart_helper.dart';

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

  List<Product> _cart = [];
  bool _isLoading = false;

  List<Product> get cart => _cart;

  bool get isLoading => _isLoading;

  set cart(List<Product> newCart) {
    _cart = newCart;
    notifyListeners();
  }

  set isLoading(bool newState) {
    _isLoading = newState;
    notifyListeners();
  }

  Future<void> refreshCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cart = await CartHelper().getCart();
    } catch (e) {
      debugPrint("Cart fetch error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateQuantity(String cartId, String action) async {
    if (_isLoading) return; // prevent spam tap

    _isLoading = true;
    notifyListeners();

    final index = _cart.indexWhere((e) => e.id == cartId);
    if (index == -1) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    // 1️⃣ optimistic update
    if (action == "inc") {
      _cart[index].quantity++;
    } else if (action == "dec" && _cart[index].quantity > 1) {
      _cart[index].quantity--;
    }

    notifyListeners(); // ⚡ instant UI

    // 2️⃣ server sync
    final success = await CartHelper().updateQuantity(cartId, action);

    // 3️⃣ rollback if failed
    if (!success) {
      if (action == "inc") {
        _cart[index].quantity--;
      } else {
        _cart[index].quantity++;
      }
    }

    _isLoading = false;
    notifyListeners();
  }
}
