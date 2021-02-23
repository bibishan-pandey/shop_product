import 'package:flutter/material.dart';
import 'package:shop_product/screens/cart_overview_screen.dart';
import 'package:shop_product/screens/order_overview_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Shop Product'),
            automaticallyImplyLeading: false,
            centerTitle: false,
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Cart'),
            onTap: () {
              Navigator.of(context).pushNamed(CartOverviewScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payments),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushNamed(OrderOverviewScreen.routeName);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
