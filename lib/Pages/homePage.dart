import 'dart:ui';
import 'package:e_commerce/Pages/foodPageBody.dart';
import 'package:e_commerce/Pages/loginPage.dart';
import 'package:e_commerce/Utils/Device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class homePage extends StatefulWidget {
  homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String selmun = 'Habana del Este';
  String selcat = 'cat1';
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
            onPressed: () {},
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
            GestureDetector(
              child: Container(
                width: 400,
                height: 500,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/product');
              },
            ),
            Container(
              width: 400,
              height: 500,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
            ),
            Container(
              width: 400,
              height: 500,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
            ),
            Container(
              width: 400,
              height: 500,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
            ),
            Container(
              width: 400,
              height: 500,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
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
