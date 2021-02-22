import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_product/providers/product_provider.dart';
import 'package:shop_product/widgets/product_item.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Product'),
        centerTitle: false,
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions value) {
              if (value == FilterOptions.Favorites) {
                setState(() {
                  _showFavorites = true;
                });
              } else {
                setState(() {
                  _showFavorites = false;
                });
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Show Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
        ],
      ),
      body: ProductGridView(
        showFavorites: _showFavorites,
      ),
    );
  }
}

class ProductGridView extends StatelessWidget {
  final bool showFavorites;

  const ProductGridView({
    Key key,
    this.showFavorites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _items = Provider.of<ProductProvider>(context);
    final products = showFavorites ? _items.showFavoriteItems : _items.items;

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
