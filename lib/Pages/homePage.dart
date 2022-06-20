import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Pages/foodPageBody.dart';
import 'package:e_commerce/Pages/loginPage.dart';
import 'package:e_commerce/Pages/productPage.dart';
import 'package:e_commerce/Utils/Device.dart';
import 'package:e_commerce/Utils/Responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../Utils/HeroDialogRoute.dart';
import '../Utils/Scraper.dart';

class homePage extends StatefulWidget {
  homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String selmun = 'Habana del Este';
  String selcat = 'cat1';
  List<bool> isFav = [];

  @override
  Widget build(BuildContext context) {
    const drawerHeader = UserAccountsDrawerHeader(
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.amber,
          child: FlutterLogo(
            size: 30,
          ),
        ),
        accountName: Text(
          "UserName",
          textScaleFactor: 1,
        ),
        accountEmail: Text("emailtest@email.com"));

    var w = MediaQuery.of(context).size.width;

    const menuItems = <String>[
      'Plaza de la Rev',
      'Playa',
      'Marianao',
      'Diez de Octubre',
      'Cotorro',
      'La Lisa',
      'San Miguel del Padron',
      'Habana del Este',
    ];
    const catItems = <String>['cat1', 'cat2', 'cat3', 'cat4', 'cat5'];
    final List<DropdownMenuItem<String>> _dropDownCatItems = catItems
        .map((String value) => DropdownMenuItem<String>(
              child: Center(child: Text(value, textAlign: TextAlign.center)),
              value: value,
            ))
        .toList();

    final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
        .map((String value) => DropdownMenuItem<String>(
              child: Center(child: Text(value, textAlign: TextAlign.center)),
              value: value,
            ))
        .toList();

    final _drawerItems = ListView(
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        drawerHeader,
        const ListTile(title: Text('Cuenta')),
        const ListTile(title: Text('Home')),
        const ListTile(title: Text('Categorias')),
        const ListTile(title: Text('Carrito')),
        const ListTile(title: Text('Favoritos')),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                return _AddTodoPopupCard();
              }));
            },
            icon: const Icon(Icons.favorite_border_outlined),
          ),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              icon: const Icon(Icons.account_circle_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  height: 50,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: TextField(
                          autofocus: false,
                          maxLines: 1,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'carne',
                              labelText: 'Barra de busqueda'),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              alignment: Alignment.center,
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2))),
                              fixedSize:
                                  MaterialStateProperty.all(Size(30, 60)),
                            ),
                            child: const Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 40,
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: const Text(
                              'CATEGORIAS',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.blue),
                            ),
                            items: _dropDownCatItems,
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue,
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              overflow: TextOverflow.visible,
                            ),
                            alignment: Alignment.center,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selcat = newValue;
                                });
                              }
                            },
                          ),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            icon: Icon(
                              Icons.location_on_outlined,
                              color: Colors.blue,
                            ),
                            isExpanded: true,
                            itemHeight: null,
                            items: _dropDownMenuItems,
                            value: selmun,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              overflow: TextOverflow.visible,
                            ),
                            alignment: Alignment.center,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selmun = newValue;
                                });
                              }
                            },
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                )
              ],
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                foodPageBody(),
              ],
            ),
            const Text(
              'Productos',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Responsive.isDesktop(context)
                ? Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    child: ProductsDesktop())
                : Container(
                    height: 500,
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Container(
                            height: 500,
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
                                  height: 300,
                                  margin: EdgeInsets.all(10),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                          "https://eva.uci.cu/theme/trema/pix/frontpage/Infor.jpg",
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
                                                            color:
                                                                Colors.blue)),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    // ignore: prefer_const_constructors
                                    Text(
                                      "14.99 US",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      height: 55,
                                      width: 70,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.red[800]),
                                      child: const Text(
                                        "-20%",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 24),
                                      ),
                                    ),
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
                                              isFav[0] = !isFav[0];
                                            });
                                          },
                                          icon: !isFav[0]
                                              ? const Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  size: 42,
                                                  color: Colors.red,
                                                )
                                              : const Icon(
                                                  Icons.favorite,
                                                  size: 42,
                                                  color: Colors.red,
                                                ),
                                          alignment: Alignment.center,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  margin: EdgeInsets.only(bottom: 20),
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
                                          MaterialStateProperty.all(Colors.red),
                                      fixedSize: MaterialStateProperty.all(
                                          Size(200, 50)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () async {
                            // Navigator.pushNamed(context, '/product');
                            Producto p = await Scraper.getProducto();

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) =>
                                    productPage(producto: p))));
                          },
                        );
                      },
                    ),
                  ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: _drawerItems,
      ),
    );
  }
}

Widget products(index) {
  return Container(
    width: double.infinity,
    height: 500,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.grey,
    ),
  );
}

const String _heroAddTodo = 'add-todo-hero';

class _AddTodoPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const _AddTodoPopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return RectTween(begin: begin, end: end);
          },
          child: Material(
            color: Colors.red,
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
                    width: MediaQuery.of(context).size.width - 30,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('Nombre prod'),
                            subtitle: Text('descripcion prod'),
                            trailing: Icon(Icons.cancel_outlined),
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                    "http://diplomarket-backend.herokuapp.com/media/products/bistec%20de%20cerdo/2022-06-06-333232.jpg")),
                            style: ListTileStyle.drawer,
                          ),
                          ListTile(
                            title: Text('Nombre prod'),
                            subtitle: Text('descripcion prod'),
                            trailing: Icon(Icons.cancel_outlined),
                            leading: Image.network(
                                "http://diplomarket-backend.herokuapp.com/media/products/bistec%20de%20cerdo/2022-06-06-333232.jpg"),
                            style: ListTileStyle.drawer,
                          ),
                          ListTile(
                            title: Text('Nombre prod'),
                            subtitle: Text('descripcion prod'),
                            trailing: Icon(Icons.cancel_outlined),
                            leading: Image.network(
                                "http://diplomarket-backend.herokuapp.com/media/products/bistec%20de%20cerdo/2022-06-06-333232.jpg"),
                            style: ListTileStyle.drawer,
                          ),
                          ListTile(
                            title: Text('Nombre prod'),
                            subtitle: Text('descripcion prod'),
                            trailing: Icon(Icons.cancel_outlined),
                            leading: Image.network(
                                "http://diplomarket-backend.herokuapp.com/media/products/bistec%20de%20cerdo/2022-06-06-333232.jpg"),
                            style: ListTileStyle.drawer,
                          ),
                          ListTile(
                            title: Text('Nombre prod'),
                            subtitle: Text('descripcion prod'),
                            trailing: Icon(Icons.cancel_outlined),
                            leading: Image.network(
                                "http://diplomarket-backend.herokuapp.com/media/products/bistec%20de%20cerdo/2022-06-06-333232.jpg"),
                            style: ListTileStyle.drawer,
                          ),
                        ],
                      ),
                    ),
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

class ProductsDesktop extends StatelessWidget {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(10),
          width: 360,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
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
                        "https://eva.uci.cu/theme/trema/pix/frontpage/Infor.jpg",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    "14.99 US",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 55,
                    width: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red[800]),
                    child: const Text(
                      "-20%",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 24),
                    ),
                  ),
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
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite,
                                size: 42,
                                color: Colors.red,
                              ),
                        alignment: Alignment.center,
                      )),
                ],
              ),
              SizedBox(
                height: 24,
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
                    backgroundColor: MaterialStateProperty.all(Colors.red),
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

class ProductsMobile extends StatelessWidget {
  const ProductsMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
