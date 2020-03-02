import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).featchAndSet(),
          builder: (ctx, dataSanpshot) {
            if (dataSanpshot.connectionState == ConnectionState.waiting) {
              Center(child: CircularProgressIndicator());
            } else {
              if (dataSanpshot.error != null) {
                //error
                //Do erro handling here
                return Center(
                  child: Text('An Error occured!'),
                );
              } else {
                return Consumer<Orders>(builder: (ctx,orderData,child)=>ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                ) ,); 
              }
            }
          },
        ));
  }
}
