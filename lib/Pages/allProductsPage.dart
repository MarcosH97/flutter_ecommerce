import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Models/ProductoModelResponse.dart';
import 'package:e_commerce/Pages/productPage.dart';
import 'package:e_commerce/Widgets/MobileWidgets/productsMobile.dart';
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
  callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ProductsMobile(
          id: 3,
          mun: Config.activeMun,
          axis: Axis.vertical,
        ));
  }

  Widget foodCard(index, pro) {
    List<ProductoMun> proreq = pro.results;

    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => productPage(
                          producto: Config().findProdyctByID(
                        proreq[index].id!),index: index
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
