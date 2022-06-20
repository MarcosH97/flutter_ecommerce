import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Pages/foodPageBody.dart';
import 'package:e_commerce/Utils/Scraper.dart';
import 'package:flutter/material.dart';

class productPage extends StatefulWidget {
  final Producto producto;

  const productPage(
      {Key? key,
      required this.producto})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _productPageState();
}

class _productPageState extends State<productPage> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              color: Colors.white,
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: Center(
                child: Image.network(widget.producto.imgURL,
                    fit: BoxFit.fitWidth, alignment: Alignment.center),
              ),
            ),
            IconButton(
                alignment: Alignment.center,
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/home');
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 50,
                  color: Colors.grey[100],
                )),
            Container(
              margin: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height / 2) - 30),
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 16,
                      color: Colors.grey,
                      offset: Offset(0, -5),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.producto.name,
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          decoration: TextDecoration.none)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('marca',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          decoration: TextDecoration.none)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(widget.producto.price,
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              decoration: TextDecoration.none)),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.red[700],
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('-35%',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                decoration: TextDecoration.none)),
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  Text('Stock'),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("COMPRAR"),
                      ),
                      IconButton(
                          alignment: Alignment.center,
                          onPressed: () {
                            setState(() {
                              isFav = !isFav;
                            });
                          },
                          icon: isFav
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 45,
                                )
                              : Icon(
                                  Icons.favorite_border_outlined,
                                  size: 45,
                                )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
