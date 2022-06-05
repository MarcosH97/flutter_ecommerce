import 'dart:ui';
import 'package:e_commerce/Pages/foodPageBody.dart';
import 'package:e_commerce/Pages/loginPage.dart';
import 'package:e_commerce/Utils/Device.dart';
import 'package:e_commerce/Widgets/glassmorph.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  

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
            icon: Icon(Icons.favorite_border_outlined),
          ),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              icon: Icon(Icons.account_circle_outlined))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.purple[300]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.all(10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(),
                      Container(
                          width: 45,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.red[800],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Icon(
                            Icons.search_outlined,
                            color: Colors.white,
                            size: 35,
                          )),
                    ],
                  ),
                )),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                foodPageBody(),
              ],
            ),
            Text(window.physicalSize.width.toString()),
          ],
        ),
      ),
      drawer: Drawer(
        child: _drawerItems,
      ),
    );
  }
}
