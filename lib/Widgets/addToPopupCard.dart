import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Pages/productPage.dart';
import 'package:flutter/material.dart';

import '../Utils/Config.dart';

// const String _heroAddTodo = 'add-todo-hero';

class AddTodoPopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  ///
  const AddTodoPopupCard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _addToPopupCard();
}

class _addToPopupCard extends State<AddTodoPopupCard> {
  @override
  Widget build(BuildContext context) {
    List<ProductoAct> deseos = Config.wishlist;
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
                  const Text(
                    "F A V O R I T O S",
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
                            itemCount: Config.wishlist.length,
                            itemBuilder: (context, index) => ListTile(
                              title: Text(deseos[index].nombre!),
                              subtitle: Text(deseos[index].descripcion!),
                              trailing: IconButton(
                                icon: Icon(Icons.cancel_outlined),
                                onPressed: () {
                                  setState(() {
                                    Config.wishlist.removeAt(index);
                                  });
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
                                          producto: deseos[index], index: index,
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
