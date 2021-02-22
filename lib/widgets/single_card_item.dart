import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_product/providers/cart_provider.dart';

class SingleCardItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final String imageUrl;

  const SingleCardItem({
    Key key,
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.price,
    @required this.quantity,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).remove(productId);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete_outlined,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Remove',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      child: Container(
        margin: EdgeInsets.zero,
        child: ListTile(
          leading: Container(
            height: 60,
            width: 50,
            child: Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (ctx, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : LinearProgressIndicator();
              },
            ),
          ),
          title: Text(title),
          subtitle: Text('\$${price * quantity}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
