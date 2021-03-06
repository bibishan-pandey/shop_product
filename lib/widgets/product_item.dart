import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_product/models/product.dart';
import 'package:shop_product/providers/cart_provider.dart';
import 'package:shop_product/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  GridTileBar _buildHeaderGridTileBar(
    BuildContext context, {
    @required String title,
  }) {
    return GridTileBar(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
      leading: Text(
        title,
        style: TextStyle(
          // fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // not listening to the changes but using Consumer below at
    // favorites icon to listen and update the changes
    final _productItem = Provider.of<Product>(context, listen: false);
    final _cartItem = Provider.of<CartProvider>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      child: GridTile(
        header: _buildHeaderGridTileBar(
          context,
          title: _productItem.title,
        ),
        footer: GridTileBar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
          leading: Consumer<Product>(
            builder: (ctx, product, child) {
              return GestureDetector(
                child: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_outline,
                  color: product.isFavorite ? Colors.red : Colors.white,
                ),
                onTap: () {
                  product.toggleFavoriteStatus();
                },
              );
            },
          ),
          title: Text(
            '\$${_productItem.price}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: GestureDetector(
            child: Icon(Icons.shopping_cart_outlined),
            onTap: () {
              _cartItem.add(
                _productItem.id,
                _productItem.title,
                _productItem.price,
              );
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  '${_productItem.title} added to the cart',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Theme.of(context).primaryColor,
                duration: Duration(seconds: 3),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    _cartItem.removeSingleItem(_productItem.id);
                  },
                  textColor: Colors.red,
                ),
              ));
            },
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: _productItem.id,
            );
          },
          child: Image.network(
            _productItem.imageUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (ctx, child, loadingProgress) {
              return loadingProgress == null
                  ? child
                  : LinearProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
