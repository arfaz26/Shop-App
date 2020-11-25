import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/orders.dart';
import 'package:shopping_app/widgets/app_drawer.dart';
import 'package:shopping_app/widgets/order_item.dart' as oi;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/ordersScreen';
// @override
  // void initState() {
  //   Future.delayed(Duration.zero).then(
  //     (_) async {
  //       setState(() {
  //         _isLoading = true;
  //       });
  //       await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     },
  //   );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // print('running build');
    // final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, snapShot) {
          // print('future builder running');
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapShot.error != null) {
            return Center(
              child: Text('Error Occured'),
            );
          } else {
            return Consumer<Orders>(
              builder: (ctx, ordersData, child) => ListView.builder(
                itemCount: ordersData.orders.length,
                itemBuilder: (ctx, i) => oi.OrderItem(
                  ordersData.orders[i],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
