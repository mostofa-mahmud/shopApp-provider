part of screens;


class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData= Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('your orders'),
      ),

      drawer: const Appdrawer(),


      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i ) => OrderItem(orderData.orders[i]),
      ),
    );
  }
}