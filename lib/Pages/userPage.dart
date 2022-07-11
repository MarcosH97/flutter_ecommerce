import 'package:e_commerce/Services/SharedService.dart';
import 'package:e_commerce/Widgets/addToPopupCard.dart';
import 'package:flutter/material.dart';

import '../Utils/Config.dart';
import '../Utils/HeroDialogRoute.dart';
import '../Widgets/myAppBar.dart';

class userPage extends StatefulWidget {
  userPage({Key? key}) : super(key: key);

  @override
  State<userPage> createState() => _UserPageState();
}

class _UserPageState extends State<userPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context).AppBarM(),
      body: Column(children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ListTile(
                  title: Text("Nombre: " + Config.activeUser.name!),
                ),
                Divider(indent: 10, endIndent: 10),
                ListTile(
                  title: Text("Email: " + Config.activeUser.email!),
                ),
                Divider(indent: 10, endIndent: 10),
                ListTile(
                  title: Text("Dirección: " + Config.activeUser.direccion!),
                ),
                Divider(indent: 10, endIndent: 10),
                ListTile(
                  title: Text("Ciudad: " + Config.activeUser.ciudad!),
                ),
                Divider(indent: 10, endIndent: 10),
                ListTile(
                  title:
                      Text("Código Postal: " + Config.activeUser.codigoPostal!),
                ),
                Divider(indent: 10, endIndent: 10),
                ListTile(
                  title: Text("Número: " + Config.activeUser.telefono!),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              SharedService().ClearData();
              Config.login = false;
              Navigator.popAndPushNamed(context, "/home");
            },
            child: Text(
              "Cerrar cuenta",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size(200, 60)),
              backgroundColor: MaterialStateProperty.all(Config.maincolor),
            )),
      ]),
    );
  }
}
