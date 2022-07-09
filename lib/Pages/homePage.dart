import 'dart:ui';
import 'package:e_commerce/Models/Producto2.dart';
import 'package:e_commerce/Models/ProductoModelResponse.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:e_commerce/Utils/Responsive.dart';
import 'package:e_commerce/Widgets/addToPopupCard.dart';
import 'package:e_commerce/Widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import '../Utils/HeroDialogRoute.dart';
import '../Widgets/DesktopWidgets/productDesktop.dart';
import '../Widgets/MobileWidgets/productsMobile.dart';

class homePage extends StatefulWidget {
  homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  String selmun = Config.munNames[0];
  String selcat = Config.categorias[0];
  late var textController = TextEditingController();

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Nuevo IP'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Config.apiURL = "http://" + textController.text.toString();
                  Navigator.pop(context);
                },
                child: Text('SUBMIT'),
              )
            ],
          ));
  @override
  Widget build(BuildContext context) {

    var drawerHeader = UserAccountsDrawerHeader(
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.amber,
          child: Icon(Icons.person, size: 50),
        ),
        accountName: Config.isLoggedIn
            ? Text(
                Config.user.name!,
                textScaleFactor: 1,
              )
            : Text(
                "<No User>",
                textScaleFactor: 1,
              ),
        accountEmail: Config.isLoggedIn
            ? Text(Config.activeUser.email!)
            : Text("no email"));

    var w = MediaQuery.of(context).size.width;
  
    final List<DropdownMenuItem<String>> _dropDownCatItems = Config.categorias
        .map((String value) => DropdownMenuItem<String>(
              child: Center(child: Text(value, textAlign: TextAlign.center)),
              value: value,
            ))
        .toList();

    final List<DropdownMenuItem<String>> _dropDownMenuItems = Config.munNames
        .map((String value) => DropdownMenuItem<String>(
              child: Center(child: Text(value, textAlign: TextAlign.center)),
              value: value,
            ))
        .toList();

    final _drawerItems = ListView(
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text('Cuenta'),
          onTap: () {
            Config.isLoggedIn
                ? Navigator.pushNamed(context, '/user')
                : Navigator.popAndPushNamed(context, '/login');
          },
        ),
        ListTile(
          title: Text('Todos los Productos'),
          onTap: () {
            Navigator.of(context).pushNamed('/allproducts');
          },
        ),
        ListTile(title: Text('Ayuda')),
        ListTile(title: Text('Qué debe saber')),
        ListTile(title: Text('Contacto')),
        Divider(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Solo Devs",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        ListTile(
          title: Text('Cambiar IP'),
          onTap: openDialog,
        ),
      ],
    );

    return Scaffold(
      appBar: myAppBar(context: context).AppBarM(),
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
                      ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                            alignment: Alignment.center,
                            backgroundColor:
                                MaterialStateProperty.all(Config.maincolor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2))),
                            fixedSize:
                                MaterialStateProperty.all(Size(30, 60)),
                          ),
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 30,
                          ))
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
                            color: Config.maincolor,
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Config.maincolor,
                            hint: Text(
                              'CATEGORIAS',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, ),
                            ),
                            items: _dropDownCatItems,
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
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
                            color: Config.maincolor,
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Config.maincolor,
                            icon: Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                            ),
                            isExpanded: true,
                            itemHeight: null,
                            items: _dropDownMenuItems,
                            value: selmun,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
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
            // Stack(
            //   alignment: Alignment.bottomCenter,
            //   children: [
            //     foodPageBody(),
            //   ],
            // ),
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
                    height: 400,
                    child: ProductsMobile(),
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
