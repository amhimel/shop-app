import 'package:flutter/material.dart';
import 'package:shop_app/models/sneakers_model.dart';
import 'package:shop_app/services/helper.dart';
import 'package:shop_app/models/sneakers_model.dart';

class ProductNotifierProvider extends ChangeNotifier {
  int _activePage = 0;
  List<Size> _shoeSizes = [];
  List<String> _sizes = [];

  int get activePage => _activePage;

  List<Size> get shoeSizes => _shoeSizes;
  List<String> get sizes => _sizes;

  set activePage(int index) {
    _activePage = index;
    notifyListeners();
  }

  set shoeSizes(List<Size> newShoes) {
    _shoeSizes = newShoes;
    notifyListeners();
  }

  set sizes(List<String> newSize) {
    _sizes = newSize;
    notifyListeners();
  }

  //check size selection index
  void toggleCheck(int index) {
    _shoeSizes[index] = Size(
      size: _shoeSizes[index].size,
      isSelected: !_shoeSizes[index].isSelected,
      id: _shoeSizes[index].id,
    );
    notifyListeners();
  }

  late Future<List<Sneakers>> menSneaker;
  late Future<List<Sneakers>> womenSneaker;
  late Future<List<Sneakers>> kidsSneaker;
  late Future<Sneakers> sneaker;

  void getMaleSneaker() {
    menSneaker = Helper().getMenSneakers();
  }

  void getFemaleSneaker() {
    womenSneaker = Helper().getWomenSneakers();
  }

  void getKidsSneaker() {
    kidsSneaker = Helper().getKidSneakers();
  }

  //get data
  void getShoes(String category, String id) {
    if (category == "Men's Shoes") {
      sneaker = Helper().getMenSneakersByIds(id);
    } else if (category == "Women's Shoes") {
      sneaker = Helper().getWomenSneakersByIds(id);
    } else {
      sneaker = Helper().getKidSneakersByIds(id);
    }
  }
}
