import 'package:flutter/material.dart';
import 'package:shop_product/screens/add_edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem({
    Key key,
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 60,
        width: 50,
        child: Image.network(
          imageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (ctx, child, loadingProgress) {
            return loadingProgress == null ? child : LinearProgressIndicator();
          },
        ),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.edit_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AddEditProductScreen.routeName,
                  arguments: id,
                );
              },
              tooltip: 'Edit',
              color: Theme.of(context).buttonTheme.colorScheme.background,
            ),
            IconButton(
              icon: Icon(Icons.delete_outline_outlined),
              onPressed: () {},
              tooltip: 'Delete',
              color: Theme.of(context).buttonTheme.colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
