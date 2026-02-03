import 'package:flutter/services.dart' as the_bundle;
import 'package:http/http.dart' as http;
import 'package:shop_app/views/shared/export_files.dart';
import 'package:shop_app/models/sneakers_model.dart';

// this class can be used to get data from api but currently it's not have any api.now we get data from local json file
class Helper {
  static var client = http.Client();

  // get kid sneakers data from local json file
  Future<List<Sneakers>> getKidSneakers() async {
    var url = Uri.https(Config.apiUrl, Config.productsUrl);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      //this will get all product
      final kidList = sneakersFromJson(response.body);
      //now we need to separate kids sneaker
      var kid = kidList.where((element) => element.category == "Kid's Shoes");
      return kid.toList();
    } else {
      throw Exception("Failed to get kid product list");
    }
  }

  // get men sneakers data from local json file
  Future<List<Sneakers>> getMenSneakers() async {
    var url = Uri.https(Config.apiUrl, Config.productsUrl);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      //this will get all product
      final menList = sneakersFromJson(response.body);
      //now we need to separate kids sneaker
      var men = menList.where((element) => element.category == "Men's Shoes");
      return men.toList();
    } else {
      throw Exception("Failed to get men product list");
    }
  }

  // get women sneakers data from local json file
  Future<List<Sneakers>> getWomenSneakers() async {
    var url = Uri.https(Config.apiUrl, Config.productsUrl);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      //this will get all product
      final womenList = sneakersFromJson(response.body);
      //now we need to separate kids sneaker
      var women = womenList.where(
        (element) => element.category == "Women's Shoes",
      );
      return women.toList();
    } else {
      throw Exception("Failed to get women product list");
    }
  }

  Future<List<Sneakers>> search(String searchQuery) async {
    var url = Uri.https(Config.apiUrl, "${Config.searchUrl}$searchQuery");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      //this will get searched  product
      final result = sneakersFromJson(response.body);
      return result;
    } else {
      throw Exception("Failed to get women product list");
    }
  }

  // get kid sneaker by id
  Future<Sneakers> getKidSneakersByIds(String id) async {
    final String data = await the_bundle.rootBundle.loadString(
      'assets/json/kids_shoes.json',
    );
    final kidList = sneakersFromJson(data);
    final sneaker = kidList.firstWhere((sneakers) => sneakers.id == id);
    return sneaker;
  }

  // get men sneaker by id
  Future<Sneakers> getMenSneakersByIds(String id) async {
    final String data = await the_bundle.rootBundle.loadString(
      'assets/json/men_shoes.json',
    );
    final menList = sneakersFromJson(data);
    final sneaker = menList.firstWhere((sneakers) => sneakers.id == id);
    return sneaker;
  }

  // get women sneaker by id
  Future<Sneakers> getWomenSneakersByIds(String id) async {
    final String data = await the_bundle.rootBundle.loadString(
      'assets/json/women_shoes.json',
    );
    final womenList = sneakersFromJson(data);
    final sneaker = womenList.firstWhere((sneakers) => sneakers.id == id);
    return sneaker;
  }
}
