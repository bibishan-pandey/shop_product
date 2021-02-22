import 'package:flutter/material.dart';
import 'package:shop_product/helpers/dummy_data.dart';
import 'package:shop_product/models/product.dart';

// Add mixin with "with" keyword
class ProductProvider with ChangeNotifier {
  List<Product> _items = products;

  List<Product> get items {
    // wrapping list items with another list and using spread
    // operator to copy the list as we do not want the _items
    // to be accessed and modified directly
    return [..._items];
  }

  List<Product> get showFavoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  void add() {
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
