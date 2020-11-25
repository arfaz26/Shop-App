import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart.dart';
import 'package:shopping_app/providers/products_model.dart';
import 'package:shopping_app/providers/products_provider.dart';
import 'package:shopping_app/screens/cart_screen.dart';
import 'package:shopping_app/widgets/app_drawer.dart';
import 'package:shopping_app/widgets/badge.dart';
import '../widgets/products_gridview.dart';

enum FilterOption {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/ProductOverScreen';

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavorites = false;
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
//  of context only works in init is listen is set to false
    // Future.delayed(Duration.zero).then((_) {});

    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('didchange');
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetAndSetProduct().then(
        (_) {
          setState(() {
            _isLoading = false;
          });
          print('loaded data.....');
        },
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final productContainer =
    // Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) {
              // productContainer.showFavoritesOnly();
              setState(() {
                if (selectedValue == FilterOption.Favorites) {
                  // productContainer.showFavoritesOnly();
                  _showFavorites = true;
                } else {
                  // productContainer.showAll();
                  _showFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Only Favorite'),
                value: FilterOption.Favorites,
              ),
              PopupMenuItem(child: Text('Show All'), value: FilterOption.All),
            ],
          ),
          Consumer<Cart>(
            builder: (ctx, cart, ch) => Badge(
              child: ch,
              value: cart.totalCartItems.toString(),
            ),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                }),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGridView(_showFavorites),
      // drawer: AppDrawer(),
    );
  }
}
