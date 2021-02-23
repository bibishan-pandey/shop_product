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

  void add(Product product) {
    final _product = Product(
      // id might be generated in the server
      id: DateTime.now().toIso8601String(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    // _items.add(_product);
    _items.insert(0, _product);
    notifyListeners();
  }

  void update(String id, Product newProduct) {
    int index = _items.indexWhere((element) => element.id == id);
    if (index >= 0) {
      _items[index] = newProduct;
      notifyListeners();
    }
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
