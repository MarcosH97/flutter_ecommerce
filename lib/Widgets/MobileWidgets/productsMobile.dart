import 'package:e_commerce/Models/ProductoModelResponse.dart';
import 'package:flutter/material.dart';

import '../../Models/Producto.dart';
import '../../Utils/Config.dart';

class ProductsMobile extends StatefulWidget {
  final int id;
  final int mun;

  const ProductsMobile({Key? key, required this.id, required this.mun})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _productsMobile();
}

class _productsMobile extends State<ProductsMobile> {
  @override
  Widget build(BuildContext context) {
    Future func;
    switch (widget.id) {
      case 1:
        {
          func = ProductoModelResponse().getProductList();
          break;
        }
      case 2:
        {
          func = ProductoModelResponse().getProductTopSellList(widget.mun);
          break;
        }
      case 3:
        {
          func = ProductoModelResponse().getProductRecList(widget.mun);
          break;
        }
      case 4:
        {
          func = ProductoModelResponse().getProductSpecialList(widget.mun);
          break;
        }

      default:
        {
          func = ProductoModelResponse().getProductList();
          break;
        }
    }
    return FutureBuilder<dynamic>(
        future: func,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                return ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      width: 360,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: Config.maincolor,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            case ConnectionState.none:
              {
                return Text("nuller");
              }
            case ConnectionState.done:

            default:
              {
                if (snapshot.hasError) {
                  print(snapshot.data);
                  return Text(snapshot.data.toString());
                } else if (snapshot.hasData) {
                  final pr = snapshot.data;
                  switch (widget.id) {
                    case 1:
                      {
                        return forProductsOnly(pr);
                      }
                    case 2:
                      {
                        return forProductsTopSellOnly(pr);
                      }
                    case 3:
                      {
                        return forProductsRecOnly(pr);
                      }
                    case 4:
                      {
                        return forProductsOnly(pr);
                      }
                    default:
                      {
                        return forProductsOnly(pr);
                      }
                  }
                }
                return Text("null2");
              }
          }
        });
  }

  Widget forProductsOnly(pr) {
    List<Producto> proreq = pr.results!;
    return ListView.builder(
      itemCount: proreq.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(10),
          width: 360,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 250,
                margin: EdgeInsets.all(10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                        Config.apiURL+proreq[index].imgPrincipal.toString(),
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
                  proreq[index].nombre!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    "\$" + proreq[index].precio.toString(),
                    // +proreq[index].slug!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
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
                        onPressed: () {
                          setState(() {
                            if (Config.isLoggedIn) {
                              if (!Config.wishlist.contains(proreq[index])) {
                                Config.wishlist.add(proreq[index]);
                              } else {
                                Config.wishlist.remove(proreq[index]);
                              }
                            } else {
                              AlertDialog();
                            }
                          });
                        },
                        icon: !Config.wishlist.contains(proreq[index])
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
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "C O M P R A R",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ButtonStyle(
                    alignment: Alignment.center,
                    backgroundColor:
                        MaterialStateProperty.all(Config.maincolor),
                    fixedSize: MaterialStateProperty.all(Size(200, 50)),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget forProductsRecOnly(pr) {
    List<ProductoRec> proreq = pr;
    return ListView.builder(
      itemCount: proreq.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(10),
          width: 360,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 200,
                margin: EdgeInsets.all(10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(Config.apiURL+proreq[index].imgPrincipal.toString(),
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
                  proreq[index].nombre!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    "\$" + proreq[index].precio.toString(),
                    // +proreq[index].slug!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
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
                        onPressed: () {
                          setState(() {
                            if (Config.isLoggedIn) {
                              // if (!Config.wishlist.contains(proreq[index])) {
                              //   Config.wishlist.add(proreq[index]);
                              // } else {
                              //   Config.wishlist.remove(proreq[index]);
                              // }
                            } else {
                              AlertDialog();
                            }
                          });
                        },
                        icon: !Config.wishlist.contains(proreq[index])
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
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "C O M P R A R",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ButtonStyle(
                    alignment: Alignment.center,
                    backgroundColor:
                        MaterialStateProperty.all(Config.maincolor),
                    fixedSize: MaterialStateProperty.all(Size(200, 50)),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget forProductsOfDayOnly(pr) {
    List<Producto> proreq = pr.results!;
    return ListView.builder(
      itemCount: proreq.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(10),
          width: 360,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 200,
                margin: EdgeInsets.all(10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(proreq[index].imgPrincipal.toString(),
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
                  proreq[index].nombre!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    "\$" + proreq[index].precio.toString(),
                    // +proreq[index].slug!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
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
                        onPressed: () {
                          setState(() {
                            if (Config.isLoggedIn) {
                              if (!Config.wishlist.contains(proreq[index])) {
                                Config.wishlist.add(proreq[index]);
                              } else {
                                Config.wishlist.remove(proreq[index]);
                              }
                            } else {
                              AlertDialog(
                                title: Text("Debe iniciar sesión"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        this.dispose();
                                      },
                                      child: Text("Cerrar"))
                                ],
                              );
                            }
                          });
                        },
                        icon: !Config.wishlist.contains(proreq[index])
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
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "C O M P R A R",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ButtonStyle(
                    alignment: Alignment.center,
                    backgroundColor:
                        MaterialStateProperty.all(Config.maincolor),
                    fixedSize: MaterialStateProperty.all(Size(200, 50)),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget forProductsTopSellOnly(pr) {
    List<ProductoRec> proreq = pr;
    return ListView.builder(
      itemCount: proreq.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(10),
          width: 360,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 200,
                margin: EdgeInsets.all(10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(proreq[index].imgPrincipal.toString(),
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
                  proreq[index].nombre!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    "\$" + proreq[index].precio.toString(),
                    // +proreq[index].slug!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
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
                        onPressed: () {
                          setState(() {
                            if (Config.isLoggedIn) {
                              // if (!Config.wishlist.contains(proreq[index])) {
                              //   Config.wishlist.add(proreq[index]);
                              // } else {
                              //   Config.wishlist.remove(proreq[index]);
                              // }
                            } else {
                              AlertDialog();
                            }
                          });
                        },
                        icon: !Config.wishlist.contains(proreq[index])
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
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "C O M P R A R",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ButtonStyle(
                    alignment: Alignment.center,
                    backgroundColor:
                        MaterialStateProperty.all(Config.maincolor),
                    fixedSize: MaterialStateProperty.all(Size(200, 50)),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
