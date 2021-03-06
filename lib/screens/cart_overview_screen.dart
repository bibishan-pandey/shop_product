import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_product/providers/cart_provider.dart';
import 'package:shop_product/providers/order_provider.dart';
import 'package:shop_product/providers/product_provider.dart';
import 'package:shop_product/screens/order_overview_screen.dart';
import 'package:shop_product/widgets/single_card_item.dart';

class CartOverviewScreen extends StatelessWidget {
  static const routeName = '/cart-overview';

  @override
  Widget build(BuildContext context) {
    final _cartItems = Provider.of<CartProvider>(context);
    final _productItems = Provider.of<ProductProvider>(context);

    Flexible _buildFlexibleListView(
      CartProvider _cartItems,
      ProductProvider _productItems,
    ) {
      return Flexible(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          itemCount: _cartItems.items.length,
          separatorBuilder: (_, __) => Divider(),
          itemBuilder: (ctx, idx) {
            return SingleCardItem(
              id: _cartItems.items.values.toList()[idx].id,
              productId: _cartItems.items.keys.toList()[idx],
              price: _cartItems.items.values.toList()[idx].price,
              quantity: _cartItems.items.values.toList()[idx].quantity,
              title: _cartItems.items.values.toList()[idx].title,
              imageUrl: _productItems
                  .findById(_cartItems.items.keys.toList()[idx])
                  .imageUrl,
            );
          },
        ),
      );
    }

    void _showConfirmationDialog() {
      Widget cancelButton = FlatButton(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        },
      );
      Widget continueButton = RaisedButton(
        child: Text("Continue"),
        color: Theme.of(context).accentColor,
        onPressed: () {
          Provider.of<OrderProvider>(context, listen: false).add(
            _cartItems.items.values.toList(),
            _cartItems.totalPrice,
          );
          _cartItems.clear();
          Navigator.of(context, rootNavigator: true).pop('dialog');
          Navigator.of(context)
              .pushReplacementNamed(OrderOverviewScreen.routeName);
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("Order Confirmation"),
        content: Text("Would you like to confirm the order?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items (${_cartItems.itemCount})'),
        centerTitle: false,
      ),
      body: _cartItems.itemCount == 0
          ? Center(
              child: Text('No items in the cart'),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildFlexibleListView(_cartItems, _productItems),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TOTAL',
                            style: TextStyle(
                              fontSize: 22,
                              letterSpacing: 4,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline1.color,
                            ),
                          ),
                          Chip(
                            label: Text(
                              _cartItems.totalPrice.toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            avatar: Icon(
                              Icons.attach_money,
                              color: Colors.white,
                            ),
                            elevation: 5,
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: 150,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  child: RaisedButton(
                    splashColor: Theme.of(context).primaryColorDark,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: _showConfirmationDialog,
                    child: Text(
                      'Order Now',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
