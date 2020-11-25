import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/products_provider.dart';
import 'product_item.dart';

class ProductsGridView extends StatelessWidget {
  final bool showFav;
  ProductsGridView(this.showFav);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final product = showFav ? productsData.favItems : productsData.items;
    return
        // product.isEmpty
        //     ? Center(
        //         child: Text(
        //         'No Favorites',
        //         style: TextStyle(
        //           fontSize: 20,
        //         ),
        //       ))
        //     :
        GridView.builder(
      itemCount: product.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: product[index],
        // create: (ctx) => product[index],
        child: ProductItem(
            // id: products[index].id,
            // title: products[index].title,
            // imageUrl: products[index].imageUrl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
