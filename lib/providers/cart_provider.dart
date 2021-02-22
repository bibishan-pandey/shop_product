import 'package:flutter/material.dart';
import 'package:shop_product/models/cart_item.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    // return _items.length;
    int count = 0;
    if (_items.isEmpty) return count;
    _items.forEach((key, value) {
      count += value.quantity;
    });
    return count;
  }

  double get totalPrice {
    double total = 0.0;
    if (_items.isEmpty) return total;
    _items.forEach((key, value) {
      total += (value.price * value.quantity);
    });
    return total;
  }

  void add(
    String productId,
    String title,
    double price,
  ) {
    if (_items.containsKey(productId)) {
      // increase quantity by 1
      _items.update(
          productId,
          (value) => CartItem(
                id: value.id,
                title: value.title,
                quantity: value.quantity + 1,
                price: value.price,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toIso8601String(),
                title: title,
                quantity: 1,
                price: price,
              ));
    }
    notifyListeners();
  }

  void remove(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
