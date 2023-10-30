// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  const ProductOverviewScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
      ),
      body: ProductsGrid(),
    );
  }
}


