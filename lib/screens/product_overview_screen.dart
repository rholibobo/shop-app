// ignore_for_file: prefer_const_constructors, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

import '../widgets/products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text('Only Favorites'),
              ),
              PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Show All'),
              ),
            ],
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
