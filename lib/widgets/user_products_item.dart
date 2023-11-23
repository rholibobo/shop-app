// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../screens/edit_product_screen.dart';

class UserProductsItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductsItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: SizedBox(
        width: 100.0,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                Provider.of<Products>(context, listen: false).deleteItem(id);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
