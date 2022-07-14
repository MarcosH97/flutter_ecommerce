import 'dart:ui';

import 'package:e_commerce/Models/Municipio.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Models/User.dart';
import 'dart:io';
import '../Models/MunicipioModelResponse.dart';

class Config {
  static late List<Municipio> municipios;
  static late List<Componente> carrito;
  static late List<Producto> wishlist;
  static late List<String> munNames;
  static late List<String> categorias;

  static const String appName = "DiploMarket";
  static const String catAPI = "/backend/categoria/";
  static const String kartAPI = "/backend/carrito/";
  static const String userAPI = "/backend/usuario/";
  static const String userAuth = "/autenticacion/";
  static const String munAPI = "/backend/municipio/";
  static const String productAPI = "/backend/producto/";
  static const String recomendadosAPI = "/backend/recomendados/dia/";//lleva mun
  static const String masvendidosAPI = "/backend/masvendidos/ultimahora/";//lleva mun
  static const String promoAPI = '/backend/promocion/descuentos/';
  static const String especialesAPI = "/backend/producto/especiales/"; //lleva mun

  static String selectedMun = "Cerro";
  static String selectedCar = "Carnes";
  // static String apiURL = "http://www.diplomarket.com";
  static String apiURL = "https://www.diplomarket.com";
  static String token = 'token 56bb9a2bd87925b99e9bcd5619a461dcbf15d51f';
  static bool login = false;
  static int mun = 0;

  static late Promocion promo;

  static const maincolor = Color.fromARGB(255, 177, 32, 36);

  static int get activeMun => mun;
  static bool get isLoggedIn => login;

  static late User user = User();
  static User get activeUser => user;

  void setAll(){
      Config.municipios.forEach((element) {
        Config.munNames.add(element.nombre!);
      });
    print("Municipios: "+municipios.length.toString());
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('www.gooogle.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }

  int getActiveMunIndex() {
    for (int i = 0; i < municipios.length; i++) {
      if (municipios[i].nombre! == selectedMun) {
        return i;
      }
    }
    return 0;
  }
}
