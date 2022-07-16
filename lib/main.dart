import 'package:e_commerce/Models/MunicipioModelResponse.dart';
import 'package:e_commerce/Pages/allProductsPage.dart';
import 'package:e_commerce/Pages/checkoutPage.dart';
import 'package:e_commerce/Pages/helpPage.dart';
import 'package:e_commerce/Pages/homePage.dart';
import 'package:e_commerce/Pages/loginPage.dart';
import 'package:e_commerce/Pages/paypalPage.dart';
import 'package:e_commerce/Pages/paypalthree.dart';
import 'package:e_commerce/Pages/stagingPage.dart';
import 'package:e_commerce/Pages/userPage.dart';
import 'package:e_commerce/Services/SharedService.dart';
import 'package:e_commerce/Services/pushNotificationsProvider.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:e_commerce/Widgets/makePayments.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'Pages/registerPage.dart';

Future<void> main() async {
  Config.carrito = [];
  Config.wishlist = [];
  Config.munNames = [];
  Config.categorias = [];
  Config.municipios = [];
  Config.destinatarios = [];
  Config.destinos = [];
  Config.componentes = [];
  Config.ordenes = [];

  // Config().setAll;
  if (await Config().checkInternetConnection()) {
    if (Platform.isAndroid) {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
    }
  } else {
    Config.internet = false;
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _myApp();
  // This widget is the root of your application.
}

class _myApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid && Config.internet) {
      final pushprov = new PushNProvider();
      pushprov.initNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _defaultHome = loginPage();
    // loadLogin();
    SharedService().LoadData;

    return MaterialApp(
      title: 'DiploMarket',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: Config.isLoggedIn ? '/home' : '/login',
      routes: {
        '/': (context) => homePage(),
        '/home': (context) => homePage(),
        '/login': (context) => loginPage(),
        '/register': (context) => registerPage(),
        '/checkout': (context) => checkOutPage(),
        '/staging': (context) => stagePage(),
        '/allproducts': (context) => allProductsPage(),
        '/user': (context) => userPage(),
        '/paypal': (context) => PayPalLast(),
        '/help': (context) => helpPage(),
      },
    );
  }

  Future loadLogin() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    if (sh.getString('ip') != null) {
      setState(() {
        Config.apiURL = sh.getString("ip")!;
        Config().setAll;
      });
      // print(Config.apiURL);
    } else {
      setState(() {
        Config().setAll;
      });
    }
  }
}
// 