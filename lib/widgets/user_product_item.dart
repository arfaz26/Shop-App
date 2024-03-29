import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/products_provider.dart';
import 'package:shopping_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem({this.title, this.imageUrl, this.id});
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
        // child: Image.network(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    EditProductScreen.routeName,
                    arguments: id,
                  );
                }),
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () async {
                  try {
                    await Provider.of<ProductsProvider>(
                      context,
                      listen: false,
                    ).removeProduct(id);
                  } catch (error) {
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text(error.toString()),
                        duration: Duration(
                          seconds: 4,
                        ),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
