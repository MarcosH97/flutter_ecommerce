import 'package:e_commerce/Models/Componente.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:flutter/material.dart';

import '../Widgets/myAppBar.dart';

class checkOutPage extends StatefulWidget {
  checkOutPage({Key? key}) : super(key: key);

  @override
  State<checkOutPage> createState() => _checkOutPageState();
}

class _checkOutPageState extends State<checkOutPage> {
  bool buttonActive = Config.carrito.length > 0;
  List<ProductoAct> productos = Config().getProductosCarrito();
  @override
  Widget build(BuildContext context) {
    var carrito = Config.carrito;
    var config = Config();
    return Scaffold(
        appBar: myAppBar(context: context).AppBarM(),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const Text(
                  "Mi Carrito",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: Config.carrito.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          height: 100,
                          margin: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    Config.apiURL +
                                        productos[index].imgPrincipal!,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Row(children: [
                                    Center(
                                        child: Text(
                                      "\$" +
                                          config
                                              .getProductFinalPrice(
                                                  productos[index])
                                              .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                      textAlign: TextAlign.center,
                                    )
                                        // Text(Config.carrito[index].producto!.nombre!, textAlign: TextAlign.center,)
                                        ),
                                    Center(
                                        child: Text(
                                      "\$" + productos[index].precio!.cantidad!,
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    )
                                        // Text(Config.carrito[index].producto!.nombre!, textAlign: TextAlign.center,)
                                        ),
                                  ])),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(60)),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: carrito[index].cantidad != 1 ?() {
                                              if(carrito[index].cantidad! > 1){
                                                setState(() {
                                                  carrito[index].decrementCantidad();
                                                  ComponenteCreate()
                                                        .updateRespaldo(index);
                                                });
                                              }

                                            } : null,
                                            style: ButtonStyle(
                                                fixedSize:
                                                    MaterialStateProperty.all(
                                                        Size(30, 50)),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Config.maincolor),
                                                shape:
                                                    MaterialStateProperty.all(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)))),
                                            child: const Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              height: 50,
                                              width: 40,
                                              child: Text(
                                                carrito[index]
                                                    .cantidad
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Config.maincolor),
                                              )),
                                          ElevatedButton(
                                              onPressed: () {
                                                if (carrito[index].cantidad! <=
                                                    int.parse(productos[index]
                                                        .cantInventario!)) {
                                                  setState(() {
                                                    carrito[index].incrementCantidad();
                                                    ComponenteCreate()
                                                        .updateRespaldo(index);
                                                  });
                                                }
                                              },
                                              style: ButtonStyle(
                                                  fixedSize:
                                                      MaterialStateProperty
                                                          .all(Size(30, 50)),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Config.maincolor)),
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              )),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      Config.carrito.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                  ),
                                  iconSize: 30,
                                  padding: EdgeInsets.all(0))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )),
                Card(
                  color: Config.maincolor,
                  elevation: 10.0,
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Total: " +
                                    Config().getTotalPriceKart().toString(),
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "\$" +
                                    Config().getCostActiveMun().toString() +
                                    " (envío)",
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: Config.carrito.length > 0
                                ? () => Navigator.pushReplacementNamed(
                                    context, '/staging')
                                : null,
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                fixedSize: Size(250, 60),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text(
                              "P A G A R",
                              style: TextStyle(
                                  fontSize: 24, color: Config.maincolor),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
