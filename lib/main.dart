import 'package:e_commerce/Models/Producto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'Models/Gif.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Gif>> lista;

  Future<List<Gif>> _getGifs() {
    return lista;
  }

  Future<List<Producto>> prods;

  Future<List<Producto>> _getProductos() async {
    final response = await http.get(
        "https://api.giphy.com/v1/gifs/trending?api_key=3NX1Mo2zvXicwQp42SjR6ESUbWO4Ykoo&limit=10&rating=g");

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    super.initState();
    _getProductos();
  }

  static const _menuItems = <String>[
    'Diez de Octubre',
    'Plaza de la Rev',
    'Habana del Este',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = _menuItems
      .map(
        (String value) =>
            DropdownMenuItem<String>(value: value, child: Text(value)),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    const drawerHeader = UserAccountsDrawerHeader(
      accountName: Text("User"),
      accountEmail: Text("email@algo.com"),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.amber,
        child: FlutterLogo(size: 42),
      ),
    );

    final DrawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: const Text("data"),
          onTap: () => Navigator.of(context).push(_NewPage(1)),
        )
      ],
    );

    String _selValue = 'Diez';

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.account_circle_outlined))
        ],
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('seleccione municipio'),
            trailing: DropdownButton<String>(
              value: 'Diez de Octubre',
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() => _selValue = newValue);
                }
              },
              items: _dropDownMenuItems,
            ),
          ),
          Row(
            children: [
              Container(
                height: 50,
                width: 100,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                    right: 0, left: 10, top: 10, bottom: 5),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                ),
              ),
              Container(
                height: 50,
                width: 100,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                    right: 10, left: 0, top: 10, bottom: 5),
                child: const Text("test"),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.all(10),
            child: const Text(
              "hello",
              textScaleFactor: 3,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.all(10),
            child: Text(
              "hello",
              textScaleFactor: 3,
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: DrawerItems,
      ),
    );
  }
}

class _NewPage extends MaterialPageRoute<void> {
  _NewPage(int id)
      : super(builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                title: Text('test'),
                elevation: 1,
              ),
              body: Center(
                child: Text('f'),
              ));
        });
}
