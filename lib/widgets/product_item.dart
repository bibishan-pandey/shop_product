import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_product/models/product.dart';
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
          fontSize: 22,
          color: Colors.white,
        ),
        softWrap: true,
        overflow: TextOverflow.fade,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _item = Provider.of<Product>(context);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      child: GridTile(
        header: _buildHeaderGridTileBar(
          context,
          title: _item.title,
        ),
        footer: GridTileBar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
          leading: GestureDetector(
            child: Icon(
              _item.isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: _item.isFavorite ? Colors.red : Colors.white,
            ),
            onTap: () {
              _item.toggleFavoriteStatus();
            },
          ),
          title: Text(
            '\$${_item.price}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: GestureDetector(
            child: Icon(Icons.shopping_cart_outlined),
            onTap: () {},
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: _item.id,
            );
          },
          child: Image.network(
            _item.imageUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
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
