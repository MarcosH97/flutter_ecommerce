import 'package:flutter/material.dart';

import '../../Models/Producto2.dart';
import '../../Models/ProductoModelResponse.dart';
import '../../Utils/Config.dart';

class ProductsMobile extends StatelessWidget {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: ProductoModelResponse().getProductList(),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 100,
                            margin: EdgeInsets.all(10),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(" ", fit: BoxFit.fill,
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
                        ],
                      ),
                    );
                  },
                );
              }
            case ConnectionState.none:
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 100,
                            margin: EdgeInsets.all(10),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(" ", fit: BoxFit.fill,
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
                        ],
                      ),
                    );
                  },
                );
              }
            case ConnectionState.done:

            default:
              {
                if (snapshot.hasError) {
                  return Text(snapshot.data.toString());
                } else if (snapshot.hasData) {
                  final pr = snapshot.data;
                  List<Producto> proreq = pr.results!;
                  return ListView.builder(
                    itemCount: 5,
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
                              height: 100,
                              margin: EdgeInsets.all(10),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                      proreq[index].imgPrincipal.toString(),
                                      fit: BoxFit.fill, loadingBuilder:
                                          (context, child, progress) {
                                    return progress == null
                                        ? child
                                        : Container(
                                            width: 50,
                                            height: 50,
                                            child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Colors.blue)),
                                          );
                                  }, errorBuilder:
                                          (context, error, stacktrace) {
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
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
                                      onPressed: () {},
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                style: ButtonStyle(
                                  alignment: Alignment.center,
                                  backgroundColor:
                                      MaterialStateProperty.all(Config.maincolor),
                                  fixedSize:
                                      MaterialStateProperty.all(Size(200, 50)),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
                return Text("null2");
              }
          }
          ;
          return Text("null");
        });
  }
}
