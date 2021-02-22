import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_product/providers/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;

    // listen: false -> if the product changes the widget will not rebuild
    final _items = Provider.of<ProductProvider>(context, listen: false);
    final product = _items.findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: false,
      ),
      body: Center(
        child: Text('Product $id'),
      ),
    );
  }
}
