import 'dart:ui';

import 'package:e_commerce/Models/Municipio.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Models/ProductoModelResponse.dart';
import 'package:e_commerce/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Categoria.dart';
import '../Models/CategoriaModelResponse.dart';
import '../Models/MunicipioModelResponse.dart';
import '../Models/PromoModelResponse.dart';

class Config {
  static late List<Municipio> municipios;
  static late List<Componente> carrito;
  static late List<Producto> wishlist;
  static late List<String> munNames;
  static late List<String> categorias;

  static const String appName = "DiploMarket";
  static const String catAPI = "/api/categoria/";
  static const String kartAPI = "/api/carrito/";
  static const String userAPI = "/api/usuario/";
  static const String userAuth = "/autenticacion/";
  static const String munAPI = "/api/municipio/";
  static const String productAPI = "/api/producto/";
  static const String promoAPI = '/api/promocion/descuentos/';

  static String selectedMun = "Cerro";
  static String selectedCar = "Carnes";
  static String apiURL = "http://127.0.0.1:8000";
  static String token = 'token 54cefb0aabf266f83383cec926ef5073dc156f2e';
  static bool login = false;
  static int mun = 0;

  static late Promocion promo;

  static const maincolor = Color.fromARGB(255, 177, 32, 36);

  static int get activeMun => mun;
  static bool get isLoggedIn => login;

  static late User user = User();
  static User get activeUser => user;

  Future<void> setAll() async {
    if (MunicipioModelResponse().getMunicipios() != null) {
      Config.municipios = await MunicipioModelResponse().getMunicipios();
      Config.municipios.forEach((element) {
        Config.munNames.add(element.nombre!);
      });
    } else {
      print("null request");
    }
    if (CategoriaModelResponse().getCategorias() != null) {
      CategoriaRequest cats = await CategoriaModelResponse().getCategorias();
      cats.results!.forEach((element) {
        Config.categorias.add(element.nombre!);
      });
    }
    if (ProductoModelResponse().getPromo() != null) {
      Config.promo = await ProductoModelResponse().getPromo();
    }
  }
}
