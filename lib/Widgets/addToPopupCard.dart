import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Pages/productPage.dart';
import 'package:e_commerce/Providers/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Utils/Config.dart';

// const String _heroAddTodo = 'add-todo-hero';

class AddTodoPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  // final Function callback;

  const AddTodoPopupCard({
    Key? key,
    // required this.callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ProductoMun> deseos = context.watch<Wishlist>().getLista;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Hero(
          tag: "FavList",
          createRectTween: (begin, end) {
            return RectTween(begin: begin, end: end);
          },
          child: Material(
            color: Config.maincolor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'fav'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    // alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 30,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: deseos.length > 0
                        ? ListView.builder(
                            itemCount: deseos.length,
                            itemBuilder: (context, index) => ListTile(
                              title: Text(deseos[index].nombre!),
                              // subtitle: Text(deseos[index].descripcion!),
                              trailing: IconButton(
                                icon: Icon(Icons.cancel_outlined),
                                onPressed: () {
                                  context.read<Wishlist>().removeProduct(index);
                                  // Config.wishlist.removeAt(index);
                                  // callback;
                                },
                              ),
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(Config.apiURL +
                                      deseos[index].imgPrincipal!)),
                              style: ListTileStyle.list,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => productPage(
                                          producto: Config().findProdyctByID(deseos[index].id!),
                                          index: index,
                                          // callback: callback,
                                        )));
                              },
                            ),
                          )
                        : Center(
                            child: Text("No hay productos en favoritos",
                                style: TextStyle(fontSize: 24))),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
