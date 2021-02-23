import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_product/providers/product_provider.dart';
import 'package:shop_product/screens/add_edit_product_screen.dart';
import 'package:shop_product/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product';

  @override
  Widget build(BuildContext context) {
    final _productItems = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            tooltip: 'Add',
            onPressed: () {
              Navigator.of(context).pushNamed(AddEditProductScreen.routeName);
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        itemCount: _productItems.items.length,
        itemBuilder: (ctx, idx) {
          return UserProductItem(
            title: _productItems.items[idx].title,
            imageUrl: _productItems.items[idx].imageUrl,
          );
        },
        separatorBuilder: (_, __) => Divider(),
      ),
    );
  }
}
