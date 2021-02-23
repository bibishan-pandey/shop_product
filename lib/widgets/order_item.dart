import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_product/models/order.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  const OrderItem({
    Key key,
    this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 0,
      ),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text(
              DateFormat().add_yMMMMEEEEd().add_jm().format(order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
