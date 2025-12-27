import 'package:flutter/services.dart' as the_bundle;
import 'package:shop_app/models/sneakers_model.dart';

// this class can be used to get data from api but currently it's not have any api.now we get data from local json file
class Helper {
  // get kid sneakers data from local json file
  Future<List<Sneakers>> getKidSneakers() async {
    final String data = await the_bundle.rootBundle.loadString(
      'assets/json/kids_shoes.json',
    );
    final kidList = sneakersFromJson(data);
    return kidList;
  }

  // get men sneakers data from local json file
  Future<List<Sneakers>> getMenSneakers() async {
    final String data = await the_bundle.rootBundle.loadString(
      'assets/json/men_shoes.json',
    );
    final menList = sneakersFromJson(data);
    return menList;
  }

  // get women sneakers data from local json file
  Future<List<Sneakers>> getWomenSneakers() async {
    final String data = await the_bundle.rootBundle.loadString(
      'assets/json/women_shoes.json',
    );
    final womenList = sneakersFromJson(data);
    return womenList;
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
