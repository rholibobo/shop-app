// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/helpers/custom_route.dart';
import './screens/splash_screen.dart';

import './providers/orders.dart';
import './providers/auth.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';

import './providers/products_provider.dart';
import './providers/cart.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          // ChangeNotifierProxyProvider<Auth, Products>(create: (ctx, auth, previousProducts) => Products(auth.token, previousProducts == null ? [] : previousProducts.items),
          // ),
          ChangeNotifierProxyProvider<Auth, Products>(
              create: (_) => Products('', "", []),
              update: (ctx, auth, previousProducts) => Products(
                  auth.token,
                  auth.userId!,
                  previousProducts == null ? [] : previousProducts.items)),
          // ChangeNotifierProxyProvider<Auth, Cart>(
          //     create: (_) => Cart('', {}),
          //     update: (ctx, auth, previousProducts) => Cart(
          //         auth.token as String,
          //         previousProducts == null ? {} : previousProducts.items)),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
              create: (_) => Orders("", "", []),
              update: (ctx, auth, previousOrders) => Orders(
                  auth.token!,
                  auth.userId!,
                  previousOrders == null ? [] : previousOrders.orders)),
          // ChangeNotifierProvider.value(
          //   value: Orders(),
          // ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'MyShop',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: Colors.purple,
                secondary: Colors.deepOrange,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.blue
              ),
              fontFamily: 'Lato',
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(), 
              }),
              textTheme: TextTheme(
                titleSmall: TextStyle(color: Colors.deepOrange),
              ),
            ),
            home: auth.isAuth
                ? ProductOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              ProductDetailScreen.routeName: (ctx) =>
                  const ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            },
          ),
        ));
  }
}
