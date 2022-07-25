import 'dart:convert';

import 'package:e_commerce/Models/Carrito.dart';
import 'package:e_commerce/Models/Componente.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Pages/productPage.dart';
import '../Utils/Config.dart';

class FoodCardW extends StatelessWidget {
  final ProductoAct productReq;
  final int index;
  final Function callback;

  FoodCardW(
      {Key? key,
      required this.productReq,
      required this.index,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool inKart;
    bool inWL;
    bool outofstock;
    ProductoAct producto = productReq;
    inKart = Config().inCarrito(producto);
    inWL = Config().inWishlist(producto);
    outofstock = int.parse(productReq.cantInventario!) > 0;

    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => productPage(
                        producto: producto,
                        index: index,
                      )));
        },
        child: SizedBox(
          width: 360,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 300,
                width: 400,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(top: 15, right: 20, left: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                        Config.apiURL + producto.imgPrincipal.toString(),
                        fit: BoxFit.fitHeight,
                        loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : Container(
                              width: 50,
                              height: 50,
                              child: const Center(
                                  child: CircularProgressIndicator(
                                      color: Config.maincolor)),
                            );
                    }, errorBuilder: (context, error, stacktrace) {
                      return const Icon(
                        Icons.error,
                        size: 50,
                        color: Colors.grey,
                      );
                    })),
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
                          text: producto.nombre!,
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
                          text: producto.marca!.nombre!,
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
                        "${Config().getProductFinalPrice(producto).toString()} \$",
                        // +producto[index].slug!,
                        style: const TextStyle(
                          color: Config.maincolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    if (Config().getProductFinalPrice(producto) <
                        double.parse(producto.precio!.cantidad!))
                      Expanded(
                        child: Text(
                          "${producto.precio!.cantidad} \$",
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
                      flex: 2,
                      child: Container(
                          height: 55,
                          width: 42,
                          alignment: Alignment.topRight,
                          child: IconButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              if (Config.isLoggedIn) {
                                if (!inWL) {
                                  Config.wishlist.add(producto);
                                  callback();
                                } else {
                                  Config.wishlist.removeAt(index);
                                  callback();
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
                        onPressed: !inCarrito(producto)
                            ? () {
                                if (Config.isLoggedIn) {
                                  Componente_Carrito()
                                      .createCompCart(Componente_Carrito(cantidad: 1, producto: int.parse(producto.id!), carrito: Config.kart.pk));
                                  Config.carrito.add(Componente(
                                      producto: producto.id,
                                      cantidad: 1,
                                      respaldo:
                                          Config().getRespaldo(producto)));
                                  callback();
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
                          !inCarrito(producto) ? "buy".tr : "added".tr,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor: !inCarrito(producto)
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

  bool inCarrito(ProductoAct producto) {
    bool inKart = false;
    Config.carrito.forEach((element) {
      if (element.producto == producto.id) {
        inKart = true;
      }
    });
    return inKart;
  }
}
