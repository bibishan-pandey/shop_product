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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 500,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.network(
                      product.imageUrl,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        return loadingProgress == null
                            ? child
                            : LinearProgressIndicator();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  width: (MediaQuery.of(context).size.width -
                          MediaQuery.of(context).viewInsets.left -
                          MediaQuery.of(context).viewInsets.right) *
                      0.4,
                  child: Text(
                    product.title,
                    style: TextStyle(
                        fontSize: 23,
                        color: Theme.of(context).textTheme.headline1.color),
                    overflow: TextOverflow.fade,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  child: Chip(
                    label: Text(
                      product.price.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 23,
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
                ),
              ],
            ),
            Divider(),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              width: double.infinity,
              child: Text(
                product.description,
                style: TextStyle(
                  fontSize: 20,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
