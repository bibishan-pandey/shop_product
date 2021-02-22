import 'package:flutter/material.dart';
import 'package:shop_product/models/cart_item.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items;

  Map<String, CartItem> get items {
    return {...items};
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
  }
}
