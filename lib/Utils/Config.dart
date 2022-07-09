import 'dart:ui';

import 'package:e_commerce/Models/Municipio.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Models/Producto2.dart';
import 'package:e_commerce/Models/User.dart';

class Config {
  static late List<Municipio> municipios;
  static late List<Producto> carrito;
  static late List<Producto> wishlist;
  static late List<String> munNames;
  static late List<String> categorias;

  static const String appName = "DiploMarket";
  static const String catAPI = "/api/categoria/";
  static const String userAPI = "/api/usuario/";
  static const String userAuth = "/autenticacion/";
  static const String munAPI = "/api/municipio";
  static const String productAPI = "/api/producto";
  static const String promoAPI = '/api/promocion/descuentos/';
  static String apiURL = "http://127.0.0.1:8000";
  static String token = 'token b8a8553ee240aa8a235f326bfb6330963e1eab4e';
  static bool login = false;
  static int mun = 0;

  static late Promocion promo;

  static const maincolor = Color.fromARGB(255, 177, 32, 36);

  static int get activeMun => mun;
  static bool get isLoggedIn => login;

  static late User user = User();
  static User get activeUser => user;
}
