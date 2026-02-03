import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/cart/addToCart.dart';
import 'package:shop_app/models/orders/order_res.dart';
import 'package:shop_app/views/shared/export_files.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart/getCart.dart';

class CartHelper {
  static var client = http.Client();

  Future<bool> addToCart(AddToCart model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');

    if (userToken == null || userToken.isEmpty) {
      throw Exception("User token not found. Please login again.");
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken',
    };

    var url = Uri.https(Config.apiUrl, Config.addCartUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    print('Token: $userToken');
    print('Response Status: ${response.statusCode}');

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteCart(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');

    if (userToken == null || userToken.isEmpty) {
      throw Exception("User token not found. Please login again.");
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken',
    };

    var url = Uri.https(Config.apiUrl, "${Config.addCartUrl}/$id");
    var response = await client.delete(url, headers: requestHeaders);

    print('Token: $userToken');
    print('Response Status: ${response.statusCode}');

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Product>> getCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');

    if (userToken == null || userToken.isEmpty) {
      throw Exception("User token not found. Please login again.");
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken',
    };

    var url = Uri.https(Config.apiUrl, Config.getCartUrl);
    var response = await client.get(url, headers: requestHeaders);

    print('Token: $userToken');
    print('Response Status: ${response.statusCode}');

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Product> cart = [];
      var products = jsonData[0]['products'];
      cart = List<Product>.from(
        products.map((product) => Product.fromJson(product)),
      );
      return cart;
    } else {
      throw Exception("Failed get cart item: ${response.statusCode}");
    }
  }

  Future<List<PaidOrders>> getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');

    if (userToken == null || userToken.isEmpty) {
      throw Exception("User token not found. Please login again.");
    }

    final headers = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken',
    };

    final url = Uri.https(Config.apiUrl, Config.ordersUrl);
    final response = await client.get(url, headers: headers);

    log("Response Status: ${response.statusCode}");
    log("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);

      return decoded
          .map((e) => PaidOrders.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("Failed get order item");
    }
  }

  Future<bool> updateQuantity(String cartItemId, String action) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("userToken");

    final url = Uri.https(Config.apiUrl, Config.updateCartUrl);

    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "token": "Bearer $token",
      },
      body: jsonEncode({
        "cartItemId": cartItemId,
        "action": action, // inc / dec
      }),
    );

    print("UPDATE STATUS: ${response.statusCode}");
    return response.statusCode == 200;
  }
}
