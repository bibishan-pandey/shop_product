import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_product/providers/product_provider.dart';
import 'package:shop_product/widgets/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Product'),
        centerTitle: false,
      ),
      body: ProductGridView(),
    );
  }
}

class ProductGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _items = Provider.of<ProductProvider>(context);
    final products = _items.items;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3,
        childAspectRatio: 1.5 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 10,
        bottom: 10,
      ),
      itemCount: products.length,
      itemBuilder: (ctx, idx) {
        // adding listeners to notify to each Products
        return ChangeNotifierProvider.value(
          // create: (ctx) => products[idx],
          value: products[idx],
          child: ProductItem(),
        );
      },
    );
  }
}
