import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_product/providers/order_provider.dart';

class OrderOverviewScreen extends StatelessWidget {
  static const routeName = '/order-overview';

  @override
  Widget build(BuildContext context) {
    final _orderItems = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        centerTitle: false,
      ),
      body: Container(
        child: Text(_orderItems.items.length.toString()),
      ),
    );
  }
}
