import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:flutter/material.dart';

import '../Models/Componente.dart';

class productPage extends StatefulWidget {
  final ProductoAct producto;

  const productPage({
    required this.producto,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _productPageState();
}

class _productPageState extends State<productPage> {
  bool isFav = false;

  double getDiscount() {
    if (widget.producto.promocion != null) {
      print("es nullo");
      if (widget.producto.promocion!.activo!) {
        return double.parse(widget.producto.precio!.cantidad!) *
            widget.producto.promocion!.descuento! /
            100;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              // width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: Image.network(
                  Config.apiURL + widget.producto.imgPrincipal!,
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center),
            ),
            // IconButton(
            //     alignment: Alignment.center,
            //     onPressed: () {
            //       Navigator.popAndPushNamed(context, '/home');
            //     },
            //     icon: Icon(
            //       Icons.arrow_back_ios,
            //       size: 50,
            //       color: Colors.grey[100],
            //     )),
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
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(widget.producto.nombre!,
                          style: const TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Verdana")),
                      const SizedBox(
                        height: 10,
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        alignment: Alignment.center,
                        onPressed: () {
                          if (Config.isLoggedIn) {
                            setState(() {
                              if (!Config.wishlist.contains(widget.producto)) {
                                Config.wishlist.add(widget.producto);
                              } else {
                                Config.wishlist.remove(widget.producto);
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
                        icon: !Config.wishlist.contains(widget.producto)
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
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text("marca: " + widget.producto.marca!.nombre!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            decoration: TextDecoration.none)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                            "\$" +
                                (getDiscount() > 0
                                    ? getDiscount().toString()
                                    : widget.producto.precio!.cantidad!) +
                                " USD",
                            style: const TextStyle(
                                fontSize: 28,
                                color: Colors.black,
                                fontFamily: "Arial")),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      getDiscount() > 0
                          ? Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.red[700],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                  widget.producto.promocion != null
                                      ? ('-' +
                                          widget.producto.promocion!.descuento
                                              .toString() +
                                          '%')
                                      : " ",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      decoration: TextDecoration.none)),
                            )
                          : SizedBox(),
                    ],
                  ),
                  Expanded(
                      child:
                          Text("Descripción: " + widget.producto.descripcion!)),
                  Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                          'Stock: ' + widget.producto.cantInventario.toString(),
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontFamily: "Arial",
                              fontSize: 16))),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: !Config().inCarrito(widget.producto)
                            ? () {
                                if (Config.isLoggedIn) {
                                  setState(() {
                                    Config.carrito.add(Componente(
                                        producto: widget.producto.id,
                                        cantidad: 1,
                                        respaldo: Config()
                                            .getRespaldo(widget.producto)));
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
                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(150, 50)),
                            backgroundColor: MaterialStateProperty.all(
                                !Config().inCarrito(widget.producto)
                                    ? Config.maincolor
                                    : Colors.red[100]),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        child: Text(
                            !Config().inCarrito(widget.producto)
                                ? "COMPRAR"
                                : "AÑADIDO",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Arial",
                                fontSize: 18)),
                      ),
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
