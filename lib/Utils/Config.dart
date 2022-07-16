import 'dart:ui';
import 'package:e_commerce/Models/Categoria.dart';
import 'package:e_commerce/Models/Destinatario.dart';
import 'package:e_commerce/Models/Municipio.dart';
import 'package:e_commerce/Models/Order.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Models/User.dart';
import 'dart:io';
import '../Models/Componente.dart';
import '../Models/MunicipioModelResponse.dart';
import '../Models/ProductoModelResponse.dart';

class Config {
  static late List<Municipio> municipios;
  static late List<Componente> carrito;
  static late List<ProductoAct> wishlist;
  static late List<Destinatario> destinatarios;
  static late List<Categoria> categories;
  static late List<String> munNames;
  static late List<String> categorias;
  static late List<String> destinos;
  static late List<Componente> componentes;
  static late List<Orden> ordenes;

  static const String appName = "DiploMarket";
  static const String checkoutAPI = "/backend/checkout/";
  static const String catAPI = "/backend/categoria/";
  static const String kartAPI = "/backend/carrito/";
  static const String userAPI = "/backend/usuario/";
  static const String userAuth = "/backend/autenticacion/";
  static const String munAPI = "/backend/municipio/";
  static const String productAPI = "/backend/producto/";
  static const String recomendadosAPI =
      "/backend/recomendados/dia/"; //lleva mun
  static const String masvendidosAPI =
      "/backend/masvendidos/ultimahora/"; //lleva mun
  static const String promoAPI = '/backend/promocion/descuentos/';
  static const String especialesAPI =
      "/backend/producto/especiales/"; //lleva mun

  static String selectedMun = "Playa";
  static String selectedCar = "Carnes";
  static String language = "es-es";
  static String currency = "USD";
  // static String apiURL = "http://www.diplomarket.com";
  static String apiURL = "https://www.diplomarket.com";
  static String token = 'token 56bb9a2bd87925b99e9bcd5619a461dcbf15d51f';
  static bool login = false;
  static int mun = 0;
  static int destiny = 0;
  static bool internet = true;

  static late Promocion promo;

  static const maincolor = Color.fromARGB(255, 177, 32, 36);
  static const secondarycolor = Color.fromARGB(255, 27, 39, 79);

  static int get activeMun => mun;
  static int get activeDest => destiny;
  static bool get isLoggedIn => login;

  static late User user = User();
  static User get activeUser => user;

  void setAll() {
    Config.municipios.forEach((element) {
      if (!munNames.contains(element.nombre))
        Config.munNames.add(element.nombre!);
    });
    Config.categorias.forEach((element) {});

    // print("Municipios: "+municipios.length.toString());
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

  double getCostActiveMun() {
    double d = 0;
    municipios.forEach((element) {
      if (element.nombre == selectedMun) {
        d = element.precioEntrega!;
      }
    });
    return d;
  }

  double getTotalCost() {
    double total = 0;
    carrito.forEach((element) {
      // total +=
    });
    return 0;
  }

  double getProductFinalPrice(ProductoAct p) {
    if (p.promocion!.activo! && p.promocion != null) {
      return double.parse(p.precio!.cantidad!) * p.promocion!.descuento! / 100;
    } else if (p.precio != null) {
      return double.parse(p.precio!.cantidad!);
    } else {
      return 0;
    }
  }

  void setupDestinatarios() {
    destinatarios.forEach((element) {
      if (!destinos.contains(element.nombre)) {
        destinos.add(element.nombre!);
      }
    });
  }

  double getTotalPriceKart() {
    double total = 0;
    carrito.forEach((element) {
      // print(element.respaldo);
      // total += element.respaldo!;
    });
    return total;
  }

  double getTotalPriceSaved() {
    double total = 0;
    carrito.forEach((element) {
      total += element.respaldo!;
    });
    return total;
  }

  double getLocalTotalPrice(ProductoAct producto, int cantidad) {
    return double.parse(producto.precio!.cantidad!) * cantidad;
  }

  Future<ProductoAct> getProducto(String id) async {
    var pro;
    List<ProductoAct>? productos =
        await ProductoModelResponse().getProductRecList();
    productos!.forEach((element) {
      if (element.id == id) {
        pro = element;
        // print("product found");
      }
    });
    if (pro != null) {
      return pro;
    }
    return ProductoAct();
  }

  Future<List<ProductoAct>> getProductosCarrito() async{
    List<ProductoAct> listado = [];
    carrito.forEach((element) async {
      listado.add(await getProducto(element.producto!));
      // print("product added");
    });
    return listado;
  }

  double getRespaldo(ProductoAct prod) {
    print(prod.id);
    return getProductFinalPrice(prod);
  }

  bool inCarrito(ProductoAct producto) {
    bool inKart = false;
    Config.carrito.forEach((element) {
      if (element.producto == producto.id) {
        inKart = true;
      }
    });
    return inKart;
  }
}
