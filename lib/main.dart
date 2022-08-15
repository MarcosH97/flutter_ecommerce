import 'dart:convert';
import 'package:e_commerce/Models/User.dart';
import 'package:e_commerce/Pages/allProductsPage.dart';
import 'package:e_commerce/Pages/checkoutPage.dart';
import 'package:e_commerce/Pages/helpPage.dart';
import 'package:e_commerce/Pages/homePage.dart';
import 'package:e_commerce/Pages/loginPage.dart';
import 'package:e_commerce/Pages/paypalPage.dart';
import 'package:e_commerce/Pages/paypalthree.dart';
import 'package:e_commerce/Pages/setupPage.dart';
import 'package:e_commerce/Pages/stagingPage.dart';
import 'package:e_commerce/Pages/userPage.dart';
import 'package:e_commerce/Providers/cartProvider.dart';
import 'package:e_commerce/Services/SharedService.dart';
import 'package:e_commerce/Services/pushNotificationsProvider.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:e_commerce/Utils/Translation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'Pages/registerPage.dart';

Future<void> main() async {
  Config.carrito = [];
  Config.wishlist = [];
  Config.munNames = [];
  Config.categorias = [];
  Config.categories = [];
  Config.municipios = [];
  Config.destinatarios = [];
  Config.destinos = [];
  Config.componentes = [];
  Config.ordenes = [];
  Config.paises = [];
  Config.paisesT = [];
  Config.provincias = [];
  Config.faqs = [];
  // Config().setAll;
  // SharedPreferences sh = await SharedPreferences.getInstance();
  // bool _login = sh.getBool('login')!;
  // Config.login = _login;
  if (await Config().checkInternetConnection()) {
    if (Platform.isAndroid) {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
    }
  } else {
    Config.internet = false;
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Wishlist()),
      ChangeNotifierProvider(create: (_) => Cart())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _myApp();
  // This widget is the root of your application.
}

class _myApp extends State<MyApp> {
  bool _login = false;
  
  @override
  void initState() {
    super.initState();

    loadLogin();

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

    return GetMaterialApp(
      translations: TranslationUtil(),
      locale: Locale('es', 'ES'),
      title: 'DiploMarket',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: _login ? '/home' : '/login',
      routes: {
        '/': (context) => homePage(),
        '/setup': (context) => setupPage(),
        '/home': (context) => homePage(),
        '/login': (context) => loginPage(),
        '/register': (context) => registerPage(),
        '/staging': (context) => stagePage(),
        '/allproducts': (context) => allProductsPage(),
        '/paypal': (context) => PayPalLast(),
        '/braintree': (context) => PayPage(),
        '/help': (context) => helpPage(),
      },
    );
  }

  Future loadLogin() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    _login = sh.getBool('login')!;
    if (_login) {
      Config.user = User.fromJson(jsonDecode(sh.getString('user')!));
    }
  }
}
// 