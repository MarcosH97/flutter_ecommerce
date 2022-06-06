import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/Pages/foodPageBody.dart';
import 'package:flutter/material.dart';

class productPage extends StatelessWidget {
  const productPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            color: Colors.green,
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: Image.asset("assets/logo.png",
                  fit: BoxFit.cover, alignment: Alignment.center),
            ),
          ),
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
                SizedBox(
                  height: 10,
                ),
                Text('nombre_prod',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        decoration: TextDecoration.none)),
                SizedBox(
                  height: 10,
                ),
                Text('marca',
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
                    Text('20.00 USD',
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
