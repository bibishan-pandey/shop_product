import 'package:flutter/material.dart';
import 'package:shop_product/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  const ProductItem({
    Key key,
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.imageUrl,
  }) : super(key: key);

  GridTileBar _buildHeaderGridTileBar(BuildContext context) {
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

  GridTileBar _buildFooterGridTileBar(BuildContext context) {
    return GridTileBar(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
      leading: GestureDetector(
        child: Icon(Icons.favorite_outline),
        onTap: () {},
      ),
      title: Text(
        '\$$price',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: GestureDetector(
        child: Icon(Icons.shopping_cart_outlined),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      child: GridTile(
        header: _buildHeaderGridTileBar(context),
        footer: _buildFooterGridTileBar(context),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: id,
            );
          },
          child: Image.network(
            imageUrl,
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
