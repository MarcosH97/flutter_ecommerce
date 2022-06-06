import 'package:e_commerce/Pages/homePage.dart';
import 'package:e_commerce/Pages/loginPage.dart';
import 'package:e_commerce/Pages/productPage.dart';
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
    return MaterialApp(
      title: 'DiploMarket',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/': (context) => homePage(),
        '/home': (context) => homePage(),
        '/login': (context) => loginPage(),
        '/register': (context) => registerPage(),
        '/product': (context) => productPage(),
      },
    );
  }
}
// 