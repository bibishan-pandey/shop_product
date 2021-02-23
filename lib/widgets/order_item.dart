import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_product/models/order.dart';

class OrderItem extends StatefulWidget {
  final Order order;

  const OrderItem({
    Key key,
    this.order,
  }) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;

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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${widget.order.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '(${widget.order.products.length} items)',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              DateFormat()
                  .add_yMMMMEEEEd()
                  .add_jm()
                  .format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Container(
              height: min(widget.order.products.length * 20.0 + 100, 180),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                itemCount: widget.order.products.length,
                itemBuilder: (ctx, idx) {
                  var total = widget.order.products[idx].price *
                      widget.order.products[idx].quantity;
                  return Container(
                    margin: EdgeInsets.zero,
                    child: ListTile(
                      title: Text(widget.order.products[idx].title),
                      subtitle: Text(
                        '\$${total.toStringAsFixed(2)}',
                      ),
                      trailing: Text(
                        '${widget.order.products[idx].quantity} x',
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => Divider(),
              ),
            ),
        ],
      ),
    );
  }
}
