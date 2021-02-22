import 'package:flutter/material.dart';

class SingleCardItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String imageUrl;

  const SingleCardItem({
    Key key,
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
