import 'dart:convert';

import 'package:e_commerce/Models/Componente.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:flutter/material.dart';

import '../Pages/productPage.dart';
import '../Utils/Config.dart';

class FoodCardW extends StatefulWidget {
  final List<ProductoAct> productReq;
  final int index;

  FoodCardW({Key? key, required this.productReq, required this.index})
      : super(key: key);

  @override
  State<FoodCardW> createState() => _FoodCardWState();
}

class _FoodCardWState extends State<FoodCardW> {
  @override
  Widget build(BuildContext context) {
    bool inKart = false;
    int index = widget.index;
    List<ProductoAct> producto = widget.productReq;

    return Card(
      elevation: 15,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      productPage(producto: producto[index])));
        },
        child: SizedBox(
          width: 360,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                margin: EdgeInsets.all(15),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                        Config.apiURL + producto[index].imgPrincipal.toString(),
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : Container(
                              width: 50,
                              height: 50,
                              child: const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.blue)),
                            );
                    }, errorBuilder: (context, error, stacktrace) {
                      return const Icon(
                        Icons.error,
                        size: 50,
                        color: Colors.grey,
                      );
                    })),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  producto[index].nombre!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "\$" +
                            Config()
                                .getProductFinalPrice(producto[index])
                                .toString(),
                        // +producto[index].slug!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Text(""),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                        height: 55,
                        width: 42,
                        alignment: Alignment.topCenter,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            if (Config.isLoggedIn) {
                              setState(() {
                                if (!Config.wishlist
                                    .contains(producto[index])) {
                                  Config.wishlist.add(producto[index]);
                                } else {
                                  Config.wishlist.remove(producto[index]);
                                }
                              });
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
                          icon: !Config.wishlist.contains(producto[index])
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
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: !inCarrito(producto[index])
                      ? () {
                          if (Config.isLoggedIn) {
                              setState(() {
                                Config.carrito.add(Componente(
                                    producto: producto[index].id, cantidad: 1, respaldo: Config().getRespaldo(producto[index])));
                              });
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
                    !inCarrito(producto[index]) ? "C O M P R A R" : "A Ñ A D I D O",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ButtonStyle(
                    alignment: Alignment.center,
                    backgroundColor: !inCarrito(producto[index])?
                        MaterialStateProperty.all(Config.maincolor):
                        MaterialStateProperty.all(Colors.red[100])
                        ,
                    fixedSize: MaterialStateProperty.all(Size(200, 50)),
                  ),
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
