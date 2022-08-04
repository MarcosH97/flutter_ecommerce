import 'package:e_commerce/Models/Carrito.dart';
import 'package:e_commerce/Models/Componente.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Providers/cartProvider.dart';
import '../Widgets/myAppBar.dart';

class checkOutPage extends StatefulWidget {
  checkOutPage({Key? key}) : super(key: key);

  @override
  State<checkOutPage> createState() => _checkOutPageState();
}

class _checkOutPageState extends State<checkOutPage> {
  bool buttonActive = Config.carrito.length > 0;
  List<ProductoAct> productos = [];

  // callback(){
  //   setState(() {

  //   });
  // }
  @override
  Widget build(BuildContext context) {
    var config = Config();
    productos = Config().getProductosCarrito(context);
    return Scaffold(
        appBar: myAppBar(
          context: context,
          // callback: callback
        ).AppBarM(),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Text(
                  'kart'.tr,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: productos.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          height: 100,
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
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
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        strutStyle: StrutStyle(fontSize: 20),
                                        text: TextSpan(
                                            text: productos[index].nombre!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    // Text(
                                    //   productos[index].nombre!,
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 18),
                                    // ),
                                    Expanded(
                                        child: Row(children: [
                                      Center(
                                          child: Text(
                                        "${config.getProductFinalPrice(productos[index])} US\$",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                            color: Config.maincolor),
                                        textAlign: TextAlign.center,
                                      )
                                          // Text(Config.carrito[index].producto!.nombre!, textAlign: TextAlign.center,)
                                          ),
                                      biggerThan(
                                              config.getProductFinalPrice(
                                                  productos[index]),
                                              double.parse(productos[index]
                                                  .precio!
                                                  .cantidad!))
                                          ? Text(
                                              "\$ ${productos[index].precio!.cantidad}",
                                              style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.grey),
                                              textAlign: TextAlign.center,
                                            )
                                          : Text(""),
                                    ])),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                            color: Config.maincolor,
                                            borderRadius:
                                                BorderRadius.circular(60)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: context
                                                            .watch<Cart>()
                                                            .getCantidad(
                                                                index) !=
                                                        1
                                                    ? () {
                                                        if (context
                                                                .watch<Cart>()
                                                                .getCantidad(
                                                                    index) >
                                                            1) {
                                                          context
                                                              .read<Cart>()
                                                              .decreaseAmmount(
                                                                  index);
                                                          // setState(() {
                                                          //   carrito[index]
                                                          //       .decrementCantidad();
                                                          ComponenteCreate()
                                                              .updateRespaldo(
                                                                  index);
                                                          // });
                                                        }
                                                      }
                                                    : null,
                                                style: ElevatedButton.styleFrom(
                                                    primary: Config.maincolor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        width: 2,
                                                        color:
                                                            Config.maincolor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  alignment: Alignment.center,
                                                  height: 50,
                                                  width: 40,
                                                  child: Text(
                                                    context
                                                        .watch<Cart>()
                                                        .getCantidad(index)
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color:
                                                            Config.maincolor),
                                                  )),
                                            ),
                                            Expanded(
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    if (context
                                                            .watch<Cart>()
                                                            .getCantidad(
                                                                index) <=
                                                        int.parse(productos[
                                                                index]
                                                            .cantInventario!)) {
                                                      context
                                                          .read<Cart>()
                                                          .increaseAmmount(
                                                              index);
                                                      // setState(() {
                                                      //   carrito[index]
                                                      //       .incrementCantidad();
                                                      ComponenteCreate()
                                                          .updateRespaldo(
                                                              index);
                                                      // });
                                                    }
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      primary:
                                                          Config.maincolor),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    context.read<Cart>().removeProduct(index);
                                    // setState(() {
                                    // print(
                                    //     "length: ${Config.comp_cart.length}");
                                    // Config.carrito.removeAt(index);
                                    // CarritoModelResponse().deleteCompcart(
                                    //     Config.comp_cart[index].id!);
                                    Componente_Carrito().deleteCompCart();
                                    // Config.comp_cart.removeAt(index);
                                    // });
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
                GestureDetector(
                  onTap: Config.carrito.length > 0
                      ? () {
                          // print(Config().addToCarritoPaypal().replaceAll(from, replace));
                          Navigator.pushReplacementNamed(context, '/staging');
                        }
                      : null,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    padding: EdgeInsets.all(5),
                    height: 70,
                    decoration: BoxDecoration(
                        color: context.watch<Cart>().listaSize > 0
                            ? Config.maincolor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(100)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text('pay'.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100)),
                            child: Text(
                              context
                                      .watch<Cart>()
                                      .getTotalPriceKart()
                                      .toString() +
                                  ' US\$',
                              softWrap: true,
                              style: TextStyle(
                                  color: Config.maincolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.all(8.0),
                //   child: Text(
                //     "Total: " + Config().getTotalPriceKart().toString(),
                //     style: TextStyle(
                //         fontSize: 26,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.white),
                //   ),
                // ),
                // Card(
                //   color: Config.maincolor,
                //   elevation: 10.0,
                //   child: Container(
                //     height: 200,
                //     width: MediaQuery.of(context).size.width,
                //     decoration: const BoxDecoration(
                //       borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(20),
                //           topRight: Radius.circular(20)),
                //     ),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [

                //         Row(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           // ignore: prefer_const_literals_to_create_immutables
                //           children: [

                //             // Padding(
                //             //   padding: EdgeInsets.all(8.0),
                //             //   child: Text(
                //             //     "\$" +
                //             //         Config().getCostActiveMun().toString() +
                //             //         " (${'delivery'.tr})",
                //             //     style: TextStyle(
                //             //         fontSize: 26,
                //             //         fontWeight: FontWeight.bold,
                //             //         color: Colors.white),
                //             //   ),
                //             // ),
                //           ],
                //         ),
                // ElevatedButton(
                //     onPressed: Config.carrito.length > 0
                //         ? () => Navigator.pushReplacementNamed(
                //             context, '/staging')
                //         : null,
                //     style: ElevatedButton.styleFrom(
                //         primary: Colors.white,
                //         fixedSize: Size(250, 60),
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10))),
                //     child: Text(
                //       'pay'.tr,
                //       style: TextStyle(
                //           fontSize: 24, color: Config.maincolor),
                //     ))
                //       ],
                //     ),
                //   ),
                // )
              ],
            )));
  }

  bool biggerThan(double a, double b) => a != b;
}
