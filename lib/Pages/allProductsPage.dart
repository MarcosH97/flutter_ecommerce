import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Models/ProductoModelResponse.dart';
import 'package:e_commerce/Pages/productPage.dart';
import 'package:flutter/material.dart';

import '../Utils/Config.dart';
import '../Utils/Device.dart';
import '../Widgets/foodCardW.dart';

class allProductsPage extends StatefulWidget {
  allProductsPage({Key? key}) : super(key: key);

  @override
  State<allProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<allProductsPage> {
  @override
  Widget build(BuildContext context) {
    // print(_products.then((value) => value));
    return Scaffold(
        body: FutureBuilder<dynamic>(
            future: ProductoModelResponse().getProductRecList(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CustomScrollView(slivers: <Widget>[
                    SliverAppBar(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 19, 51, 87),
                      floating: false,
                      pinned: true,
                      expandedHeight: 100,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: const Text(
                          "Todos los Productos",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        background: Container(
                          color: Color.fromARGB(255, 19, 51, 87),
                        ),
                      ),
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Device().isMobile(context) ? 1 : 3,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        ((context, index) {
                          return SizedBox(
                            height: 400,
                            child: Card(
                              margin: EdgeInsets.all(10),
                              elevation: 10,
                              child: Container(
                                width: 360,
                                child: const Center(
                                    child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: CircularProgressIndicator(
                                            color: Config.maincolor))),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ]);

                case ConnectionState.done:
                // {
                //   return Text("no cargo");
                // }
                default:
                  if (snapshot.hasError) {
                    print("ALL PRODUCTS: Data Error");
                    return Text(snapshot.data.toString());
                  } else if (snapshot.hasData) {
                    print('has data');
                    return CustomScrollView(slivers: <Widget>[
                      SliverAppBar(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 19, 51, 87),
                        floating: false,
                        pinned: true,
                        expandedHeight: 100,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: const Text(
                            "Todos los Productos",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          background: Container(
                            color: Color.fromARGB(255, 19, 51, 87),
                          ),
                        ),
                      ),
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Device().isMobile(context) ? 1 : 3,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          ((context, index) {
                            return FoodCardW(
                                productReq: snapshot.data, index: index);
                            // return foodCard(index, snapshot.data);
                            // return FoodCardWidget(
                            //     pr: snapshot.data, index: index);
                          }),
                          childCount: snapshot.data.length,
                        ),
                      ),
                    ]);
                  }
                  return Text("null");
              }
            }
            ));
  }

  Widget foodCard(index, pro) {
    List<ProductoAct> proreq = pro.results;

    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => productPage(producto: proreq[index])));
        },
        child: SizedBox(
          width: 360,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 300,
                margin: EdgeInsets.all(10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                        Config.apiURL + proreq[index].imgPrincipal.toString(),
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
                children: [
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
        ),
      ),
    );
  }
}
