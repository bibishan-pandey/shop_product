import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_product/providers/order_provider.dart';
import 'package:shop_product/widgets/order_item.dart';

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
      body: _orderItems.items.isEmpty
          ? Center(
              child: Text('No items in the order'),
            )
          : ListView.builder(
              itemCount: _orderItems.items.length,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              itemBuilder: (ctx, idx) {
                return OrderItem(
                  order: _orderItems.items[idx],
                );
              },
            ),
    );
  }
}
