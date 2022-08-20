import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/Models/Componente.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Models/ProductoModelResponse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Pages/productPage.dart';
import '../Providers/cartProvider.dart';
import '../Utils/Config.dart';

class FoodCardW extends StatelessWidget {
  final ProductoMun productReq;
  final int index;
  // final Function callback;

  FoodCardW({
    Key? key,
    required this.productReq,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool inKart = context.watch<Cart>().inKart(int.parse(productReq.id!));
    bool inWL = context.watch<Wishlist>().inWL(productReq.id!);
    bool outofstock;
    outofstock = int.parse(productReq.cantInventario!) > 0;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      // color: Colors.amber,
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => productPage(
                        id: productReq.id!,
                        index: index,
                      )));
        },
        child: SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 280,
                width: 300,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: 
                    CachedNetworkImage(imageUrl: Config.apiURL + productReq.imgPrincipal.toString(),
                    progressIndicatorBuilder: (context, url, progress) => LinearProgressIndicator(
                            value: progress.progress,
                          ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    ))
              ),
              Wrap(
                textDirection: TextDirection.ltr,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.topLeft,
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      strutStyle: StrutStyle(fontSize: 20),
                      text: TextSpan(
                          text: productReq.nombre!,
                          style: TextStyle(color: Colors.black, fontSize: 22)),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.topLeft,
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      strutStyle: StrutStyle(fontSize: 20),
                      text: TextSpan(
                          text: productReq.marca!.nombre!,
                          style: TextStyle(
                              color: Config.maincolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "${Config().getProductFinalPrice(int.parse(productReq.id!)).toString()} \$",
                        // +producto[index].slug!,
                        style: const TextStyle(
                          color: Config.maincolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    if (Config()
                            .getProductFinalPrice(int.parse(productReq.id!)) <
                        double.parse(productReq.precio!.cantidad!))
                      Expanded(
                        child: Text(
                          "${productReq.precio!} \$",
                          // +producto[index].slug!,
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    Expanded(
                      flex: 0,
                      child: Container(
                          height: 55,
                          width: 42,
                          alignment: Alignment.topRight,
                          child: IconButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              if (Config.isLoggedIn) {
                                if (!inWL) {
                                  context
                                      .read<Wishlist>()
                                      .addProduct(productReq);
                                  // callback();
                                } else {
                                  context.read<Wishlist>().removeProduct(index);
                                  // callback();
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text(
                                              "Debe estar autenticado para realizar esta acción"),
                                          actions: [
                                            TextButton(
                                                onPressed: (() =>
                                                    Navigator.pop(context)),
                                                child: Text('Aceptar')),
                                          ],
                                        ));
                              }
                            },
                            icon: !inWL
                                ? const Icon(
                                    Icons.favorite_border_outlined,
                                    size: 42,
                                    color: Config.maincolor,
                                  )
                                : const Icon(
                                    Icons.favorite,
                                    size: 42,
                                    color: Config.maincolor,
                                  ),
                            alignment: Alignment.center,
                          )),
                    ),
                  ],
                ),
              ),
              outofstock
                  ? Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: !inKart
                            ? () {
                                if (Config.isLoggedIn) {
                                  context.read<Cart>().addProduct(Componente(
                                      producto: int.parse(productReq.id!),
                                      cantidad: 1,
                                      respaldo: Config().getProductFinalPrice(
                                          int.parse(productReq.id!))));
                                  
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text(
                                                "Debe estar autenticado para realizar esta acción"),
                                            actions: [
                                              TextButton(
                                                  onPressed: (() =>
                                                      Navigator.pop(context)),
                                                  child: Text('Aceptar')),
                                            ],
                                          ));
                                }
                              }
                            : null,
                        child: Text(
                          !inKart ? "buy".tr : "added".tr,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor: !inKart
                              ? MaterialStateProperty.all(Config.maincolor)
                              : MaterialStateProperty.all(Colors.red[100]),
                          fixedSize: MaterialStateProperty.all(Size(200, 50)),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'outstock'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  bool inCarrito(Producto producto) {
    bool inKart = false;
    Config.carrito.forEach((element) {
      if (element.producto == producto.id) {
        inKart = true;
      }
    });
    return inKart;
  }
}
