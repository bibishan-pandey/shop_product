import 'package:flutter/material.dart';
import 'package:shop_product/models/product.dart';
import 'package:shop_product/widgets/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {
  final List<Product> products;

  const ProductOverviewScreen({
    Key key,
    this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Product'),
        centerTitle: false,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 2
                  : 3,
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
          return ProductItem(
            id: products[idx].id,
            title: products[idx].title,
            price: products[idx].price,
            imageUrl: products[idx].imageUrl,
          );
        },
      ),
    );
  }
}
