import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Models/Producto2.dart';
import 'package:e_commerce/Models/ProductoModelResponse.dart';
import 'package:e_commerce/Widgets/foodCardWidget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import '../Utils/Device.dart';

class allProductsPage extends StatefulWidget {
  allProductsPage({Key? key}) : super(key: key);

  @override
  State<allProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<allProductsPage> {
  @override
  Widget build(BuildContext context) {
    // print(_products.then((value) => value));
    return Scaffold(
        body: FutureBuilder<dynamic>(
            future: ProductoModelResponse().getProductList(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text("waiting");

                case ConnectionState.done:

                default:
                  if (snapshot.hasError) {
                    return Text(snapshot.data.toString());
                  } else if (snapshot.hasData) {
                    return CustomScrollView(slivers: <Widget>[
                      SliverAppBar(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 19, 51, 87),
                        floating: false,
                        pinned: true,
                        expandedHeight: 100,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: const Text(
                            "Todos los Productos",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          background: Container(
                            color: Color.fromARGB(255, 19, 51, 87),
                          ),
                        ),
                      ),
                      SliverGrid(

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Device().isMobile(context) ? 1 : 3,
                        ),
                        delegate: SliverChildBuilderDelegate(((context, index) {
                          return 
                          FoodCardWidget(
                              pr: snapshot.data, index: index);
                        }),
                        childCount: 10,
                        ),
                      ),
                    ]);
                  }
                  return Text("null");
              }
            }));
  }
}
