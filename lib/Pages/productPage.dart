import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Models/ProductoModelResponse.dart';
import 'package:e_commerce/Providers/cartProvider.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Models/Componente.dart';
import 'filterPage.dart';

class productPage extends StatelessWidget {
  final String id;
  final int index;
  // final Function callback;

  const productPage({
    Key? key,
    required this.id,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: ProductoModelResponse().getProductobyID(id),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              case ConnectionState.done:
                {
                  if (snapshot.hasData && snapshot.data != null) {
                    final p = snapshot.data as Producto;
                    return innerWidget(producto: p, index: index);
                  }
                  return Text("null");
                }
              default:
                {
                  break;
                }
            }
            return Text("null");
          }),
    );
  }
  // @override
  // State<StatefulWidget> createState() => _productPageState();

}

// class _productPageState extends State<productPage> {
//   bool expanded = false;
//   bool isFav = false;
//   bool inkart = false;

//   double getDiscount() {
//     if (widget.producto.promocion!.activo != null) {
//       // print("es nullo");
//       if (widget.producto.promocion!.activo!) {
//         return widget.producto.precio! *
//             widget.producto.promocion!.descuento! /
//             100;
//       }
//     }
//     return 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     inkart = context.watch<Cart>().inKart(int.parse(widget.producto.id!));
//     isFav = context.watch<Wishlist>().inWL(widget.producto.id!);
//     return Scaffold(
//       appBar: AppBar(),
//       floatingActionButton: !expanded
//           ? SizedBox(
//               height: 75,
//               width: 75,
//               child: FloatingActionButton(
//                 onPressed: !inkart
//                     ? (() => setState(() {
//                           expanded = !expanded;
//                         }))
//                     : null,
//                 child: Icon(Icons.shopping_cart_checkout, size: 30),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(100)),
//                 backgroundColor: !inkart ? Config.maincolor : Colors.grey[400],
//                 elevation: 10,
//               ),
//             )
//           : SizedBox(
//               height: 75,
//               width: 200,
//               child: FloatingActionButton.extended(
//                 onPressed: () {
//                   if (Config.isLoggedIn) {
//                     setState(() {
//                       expanded = !expanded;
//                     });
//                     context.read<Cart>().addProduct(Componente(
//                         producto: int.parse(widget.producto.id!),
//                         cantidad: 1,
//                         respaldo: Config().getProductFinalPrice(
//                             int.parse(widget.producto.id!))));
//                   } else {
//                     showDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                               title: Text(
//                                   "Debe estar autenticado para realizar esta acción"),
//                               actions: [
//                                 TextButton(
//                                     onPressed: (() => Navigator.pop(context)),
//                                     child: Text('Aceptar')),
//                               ],
//                             ));
//                   }
//                 },
//                 icon: Icon(
//                   Icons.shopping_cart_checkout,
//                   size: 40,
//                 ),
//                 isExtended: true,
//                 backgroundColor: Config.maincolor,
//                 elevation: 10,
//                 label: Text('buy'.tr),
//               ),
//             ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: double.infinity,
//         color: Colors.white,
//         child: Stack(
//           children: [
//             Container(
//                 alignment: Alignment.center,
//                 color: Colors.white,
//                 height: MediaQuery.of(context).size.height / 2 - 150,
//                 child: PageView.builder(
//                   itemCount: widget.producto.galeria!.length,
//                   itemBuilder: (context, index) {
//                     return Image.network(
//                         Config.apiURL + widget.producto.galeria![index],
//                         fit: BoxFit.fitHeight,
//                         alignment: Alignment.center,
//                         loadingBuilder: (context, child, progress) {
//                       return progress == null
//                           ? child
//                           : Container(
//                               width: 50,
//                               height: 50,
//                               child: const Center(
//                                   child: CircularProgressIndicator(
//                                       color: Config.maincolor)),
//                             );
//                     }, errorBuilder: (context, error, stacktrace) {
//                       return const Icon(
//                         Icons.error,
//                         size: 50,
//                         color: Colors.grey,
//                       );
//                     });
//                   },
//                 )),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               margin: EdgeInsets.only(
//                   top: (MediaQuery.of(context).size.height / 2) - 100),
//               alignment: Alignment.topCenter,
//               decoration: const BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 16,
//                       color: Colors.grey,
//                       offset: Offset(0, -5),
//                     )
//                   ],
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       topRight: Radius.circular(30))),
//               child: ListView(
//                 children: [
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Expanded(
//                         flex: 4,
//                         child: Text(widget.producto.nombre!,
//                             style: const TextStyle(
//                                 fontSize: 26,
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.w400)),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: IconButton(
//                           padding: EdgeInsets.all(0),
//                           alignment: Alignment.center,
//                           onPressed: () {
//                             if (Config.isLoggedIn) {
//                               if (!isFav) {
//                                 context.read<Wishlist>().addProduct(
//                                     Config().findProductoMun(widget.producto));
//                               } else {
//                                 context
//                                     .read<Wishlist>()
//                                     .removeProduct(widget.index);
//                               }
//                             } else {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialog(
//                                         title: Text(
//                                             "Debe estar autenticado para realizar esta acción"),
//                                         actions: [
//                                           TextButton(
//                                               onPressed: (() =>
//                                                   Navigator.pop(context)),
//                                               child: Text('Aceptar')),
//                                         ],
//                                       ));
//                             }
//                           },
//                           icon: !isFav
//                               ? const Icon(
//                                   Icons.favorite_border_outlined,
//                                   size: 42,
//                                   color: Config.maincolor,
//                                 )
//                               : const Icon(
//                                   Icons.favorite,
//                                   size: 42,
//                                   color: Config.maincolor,
//                                 ),
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                             "${getDiscount() > 0 ? getDiscount().toString() : widget.producto.precio!} \$",
//                             style: const TextStyle(
//                                 fontSize: 30,
//                                 color: Config.maincolor,
//                                 fontFamily: "Arial",
//                                 fontWeight: FontWeight.w600)),
//                       ),
//                       if (getDiscount() > 0)
//                         Expanded(
//                           child: Text("${widget.producto.precio!} \$",
//                               style: const TextStyle(
//                                   fontSize: 24,
//                                   color: Colors.grey,
//                                   fontFamily: "Arial",
//                                   decoration: TextDecoration.lineThrough,
//                                   fontWeight: FontWeight.w600)),
//                         ),
//                       Expanded(
//                         child: SizedBox(
//                           width: 10,
//                         ),
//                       ),
//                       if (getDiscount() > 0)
//                         Container(
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: Colors.red[700],
//                               borderRadius: BorderRadius.circular(10)),
//                           child: Text(
//                               widget.producto.promocion!.descuento != null
//                                   ? ('-' +
//                                       widget.producto.promocion!.descuento
//                                           .toString() +
//                                       '%')
//                                   : " ",
//                               style: TextStyle(
//                                   fontSize: 24,
//                                   color: Colors.white,
//                                   decoration: TextDecoration.none)),
//                         )
//                       else
//                         SizedBox(),
//                     ],
//                   ),
//                   Text(
//                       "\$ ${widget.producto.precioxlibra!} /${widget.producto.um}",
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.black,
//                       )),
//                   Divider(
//                     thickness: 2,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: RichText(
//                       text: TextSpan(
//                           style: TextStyle(color: Colors.black, fontSize: 20),
//                           children: <TextSpan>[
//                             TextSpan(
//                                 text: "${'subcat'.tr}: ",
//                                 style: TextStyle(fontWeight: FontWeight.bold)),
//                             TextSpan(
//                                 text: widget.producto.subcategoria!,
//                                 style: TextStyle(
//                                     color: Colors.grey[800],
//                                     decoration: TextDecoration.underline),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => filterPage(
//                                                 productos: Config().filter(
//                                                     widget.producto.subcategoria!,
//                                                     3),
//                                                 headerName: widget
//                                                     .producto.marca!.nombre!)));
//                                   })
//                           ]),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: RichText(
//                       text: TextSpan(
//                           style: TextStyle(color: Colors.black, fontSize: 20),
//                           children: <TextSpan>[
//                             TextSpan(
//                                 text: "${'brand'.tr}: ",
//                                 style: TextStyle(fontWeight: FontWeight.bold)),
//                             TextSpan(
//                                 text: widget.producto.marca!.nombre!,
//                                 style: TextStyle(
//                                     color: Colors.grey[800],
//                                     decoration: TextDecoration.underline),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => filterPage(
//                                                 productos: Config().filter(
//                                                     widget.producto.marca!.nombre!,
//                                                     1),
//                                                 headerName: widget
//                                                     .producto.marca!.nombre!)));
//                                   })
//                           ]),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: RichText(
//                       text: TextSpan(
//                           style: TextStyle(color: Colors.black, fontSize: 20),
//                           children: <TextSpan>[
//                             TextSpan(
//                                 text: "${'provider'.tr}: ",
//                                 style: TextStyle(fontWeight: FontWeight.bold)),
//                             TextSpan(
//                                 text: widget.producto.proveedor!.nombre!,
//                                 style: TextStyle(
//                                     color: Colors.grey[800],
//                                     decoration: TextDecoration.underline),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => filterPage(
//                                                 productos: Config().filter(
//                                                     widget.producto.proveedor!
//                                                         .nombre!,
//                                                     2),
//                                                 headerName: widget
//                                                     .producto.proveedor!.nombre!)));
//                                   })
//                           ]),
//                     ),
//                   ),
//                   Divider(
//                     thickness: 2,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: RichText(
//                       text: TextSpan(
//                           style: TextStyle(color: Colors.black, fontSize: 20),
//                           children: <TextSpan>[
//                             TextSpan(
//                                 text: "${'desc'.tr}: \n",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 24)),
//                             TextSpan(
//                               text: widget.producto.descripcion,
//                               style: TextStyle(color: Colors.grey[800]),
//                             )
//                           ]),
//                     ),

//                     // Text(
//                     //   "${'desc'.tr}: \n" + widget.producto.descripcion!,
//                     //   style: TextStyle(
//                     //       color: Colors.grey[700],
//                     //       fontFamily: "Arial",
//                     //       fontSize: 20),
//                     // ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class innerWidget extends StatefulWidget {
  final Producto producto;
  final int index;
  innerWidget({Key? key, required this.producto, required this.index})
      : super(key: key);

  @override
  State<innerWidget> createState() => _innerWidgetState();
}

class _innerWidgetState extends State<innerWidget> {
  bool expanded = false;
  bool isFav = false;
  bool inkart = false;

  double getDiscount() {
    if (widget.producto.promocion!.activo != null) {
      // print("es nullo");
      if (widget.producto.promocion!.activo!) {
        return widget.producto.precio! *
            widget.producto.promocion!.descuento! /
            100;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    inkart = context.watch<Cart>().inKart(int.parse(widget.producto.id!));
    isFav = context.watch<Wishlist>().inWL(widget.producto.id!);
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: !expanded
          ? SizedBox(
              height: 75,
              width: 75,
              child: FloatingActionButton(
                onPressed: !inkart
                    ? (() => setState(() {
                          expanded = !expanded;
                        }))
                    : null,
                child: Icon(Icons.shopping_cart_checkout, size: 30),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                backgroundColor: !inkart ? Config.maincolor : Colors.grey[400],
                elevation: 10,
              ),
            )
          : SizedBox(
              height: 75,
              width: 200,
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (Config.isLoggedIn) {
                    setState(() {
                      expanded = !expanded;
                    });
                    context.read<Cart>().addProduct(Componente(
                        producto: int.parse(widget.producto.id!),
                        cantidad: 1,
                        respaldo: Config().getProductFinalPrice(
                            int.parse(widget.producto.id!))));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text(
                                  "Debe estar autenticado para realizar esta acción"),
                              actions: [
                                TextButton(
                                    onPressed: (() => Navigator.pop(context)),
                                    child: Text('Aceptar')),
                              ],
                            ));
                  }
                },
                icon: Icon(
                  Icons.shopping_cart_checkout,
                  size: 40,
                ),
                isExtended: true,
                backgroundColor: Config.maincolor,
                elevation: 10,
                label: Text('buy'.tr),
              ),
            ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
                alignment: Alignment.center,
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 2 - 150,
                child: PageView.builder(
                  itemCount: widget.producto.galeria!.length == 0
                      ? 1
                      : widget.producto.galeria!.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                        widget.producto.galeria!.length == 0
                            ? Config.apiURL + widget.producto.imgPrincipal!
                            : Config.apiURL + widget.producto.galeria![index],
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.center,
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
                    });
                  },
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height / 2) - 100),
              alignment: Alignment.topCenter,
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
              child: ListView(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(widget.producto.nombre!,
                            style: const TextStyle(
                                fontSize: 26,
                                color: Colors.blue,
                                fontWeight: FontWeight.w400)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          alignment: Alignment.center,
                          onPressed: () {
                            if (Config.isLoggedIn) {
                              if (!isFav) {
                                context.read<Wishlist>().addProduct(
                                    Config().findProductoMun(widget.producto));
                              } else {
                                context
                                    .read<Wishlist>()
                                    .removeProduct(widget.index);
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
                          icon: !isFav
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
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                            "${getDiscount() > 0 ? getDiscount().toString() : widget.producto.precio!} \$",
                            style: const TextStyle(
                                fontSize: 30,
                                color: Config.maincolor,
                                fontFamily: "Arial",
                                fontWeight: FontWeight.w600)),
                      ),
                      if (getDiscount() > 0)
                        Expanded(
                          child: Text("${widget.producto.precio!} \$",
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.grey,
                                  fontFamily: "Arial",
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w600)),
                        ),
                      Expanded(
                        child: SizedBox(
                          width: 10,
                        ),
                      ),
                      if (getDiscount() > 0)
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.red[700],
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                              widget.producto.promocion!.descuento != null
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
                      else
                        SizedBox(),
                    ],
                  ),
                  if (widget.producto.precioxlibra! > 0 &&
                      widget.producto.um != null)
                    Text(
                        "\$ ${widget.producto.precioxlibra!} /${widget.producto.um}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )),
                  Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                                text: "${'subcat'.tr}: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: widget.producto.subcategoria!,
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => filterPage(
                                                subcat: widget.producto.subcategoria,
                                                // Config().filter(
                                                //     widget
                                                //         .producto.subcategoria!,
                                                //     3),
                                                headerName: widget
                                                    .producto.subcategoria!)));
                                  })
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                                text: "${'brand'.tr}: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: widget.producto.marca!.nombre!,
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => filterPage(
                                                productos: Config().filter(
                                                    widget.producto.marca!
                                                        .nombre!,
                                                    1),
                                                headerName: widget
                                                    .producto.marca!.nombre!)));
                                  })
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                                text: "${'provider'.tr}: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: widget.producto.proveedor!.nombre!,
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => filterPage(
                                                productos: Config().filter(
                                                    widget.producto.proveedor!
                                                        .nombre!,
                                                    2),
                                                headerName: widget.producto
                                                    .proveedor!.nombre!)));
                                  })
                          ]),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                                text: "${'desc'.tr}: \n",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24)),
                            TextSpan(
                              text: widget.producto.descripcion,
                              style: TextStyle(color: Colors.grey[800]),
                            )
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                                text: '${'avat'.tr} \n',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24)),
                            TextSpan(
                              text: getMuns(widget.producto.municipios!),
                              style: TextStyle(color: Colors.grey[800]),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getMuns(List<municipio> muns) {
    String s = '';
    for (var v in muns) {
      s += v.nombre! + ' | ';
    }
    return s;
  }
}
