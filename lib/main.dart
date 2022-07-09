import 'package:e_commerce/Models/Categoria.dart';
import 'package:e_commerce/Models/CategoriaModelResponse.dart';
import 'package:e_commerce/Models/MunicipioModelResponse.dart';
import 'package:e_commerce/Models/ProductoModelResponse.dart';
import 'package:e_commerce/Models/PromoModelResponse.dart';
import 'package:e_commerce/Pages/allProductsPage.dart';
import 'package:e_commerce/Pages/checkoutPage.dart';
import 'package:e_commerce/Pages/homePage.dart';
import 'package:e_commerce/Pages/loginPage.dart';
import 'package:e_commerce/Pages/productPage.dart';
import 'package:e_commerce/Pages/userPage.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:flutter/material.dart';

import 'Pages/registerPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget _defaultHome = loginPage();
    Config.carrito = [];
    Config.wishlist = [];
    Config.munNames = [];
    Config.categorias = [];

    setAll();

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
        '/allproducts': (context) => allProductsPage(),
        '/user': (context) => userPage(),
      },
    );
  }

  void setAll() async {
    Config.municipios = await MunicipioModelResponse().getMunicipios();
    CategoriaRequest cats = await CategoriaModelResponse().getCategorias();
    Config.promo = await PromoModelResponse().getPromo();
    Config.municipios.forEach((element) {
      Config.munNames.add(element.nombre!);
    });
    cats.results!.forEach((element) {
      Config.categorias.add(element.nombre!);
    });
  }
}
// 