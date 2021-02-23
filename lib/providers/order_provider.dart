import 'package:flutter/foundation.dart';
import 'package:shop_product/models/cart_item.dart';
import 'package:shop_product/models/order.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  void add(List<CartItem> cartProducts, double total) {
    _items.insert(
        0,
        Order(
          id: DateTime.now().toIso8601String(),
          amount: total,
          products: cartProducts,
          dateTime: DateTime.now(),
        ));
    notifyListeners();
  }
}
