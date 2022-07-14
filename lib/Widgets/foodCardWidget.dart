// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:e_commerce/Utils/Config.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

import '../Models/Producto.dart';

class FoodCardWidget extends StatefulWidget {
  final pr;
  final int index;

  const FoodCardWidget({required this.pr, required this.index, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _foodCardWidget();
}

class _foodCardWidget extends State<FoodCardWidget> {
  @override
  Widget build(BuildContext context) {
    List<Producto> p = widget.pr.results!;

    return Container(
      child: Card(
        color: Colors.amber,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: ExtendedImage.network(
                  p[widget.index].imgPrincipal!,
                  borderRadius: BorderRadius.circular(30),
                )),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.topLeft,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 10),
                      child: Text(
                        p[widget.index].nombre!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text(
                            '\$' + p[widget.index].precio!+ " USD",
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            " " + p[widget.index].precio_lb!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "-" + p[widget.index].promocion!.toString() + "%",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (!Config.wishlist.contains(p[widget.index])) {
                              Config.wishlist.add(p[widget.index]);
                            } else {
                              Config.wishlist.remove(p[widget.index]);
                            }
                              setState(() {
                                
                              });
                          },
                          icon: Icon(Config.wishlist.contains(p[widget.index]) ?
                            Icons.favorite : Icons.favorite_border_outlined
                            ,
                            size: 42,
                            color: Colors.red,
                          ),
                          alignment: Alignment.center,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (p[widget.index].cantInventario! > 0) {
                                
                              }
                            },
                            child: Text("COMPRAR"))
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],
        )),
      ),
    );
  }
}
