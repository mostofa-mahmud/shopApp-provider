import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp_udemy/providers/cart.dart';
import 'package:shopapp_udemy/providers/orders.dart';
import 'package:shopapp_udemy/screens/screens.dart';
import './providers/product_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => ProductsProvider(),),
        ChangeNotifierProvider(create: (_) => Cart(),),
        ChangeNotifierProvider(create: (_)=> Orders())

      ],



      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Lato',
          accentColor: Colors.deepOrange,
        ),


        home: ProductOverviewScreens(),


        routes: {

          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),

        },




      ),
    );
  }
}
