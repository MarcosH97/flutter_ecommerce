import 'dart:convert';
import 'dart:ui';
import 'package:e_commerce/Models/Categoria.dart';
import 'package:e_commerce/Models/Destinatario.dart';
import 'package:e_commerce/Models/Municipio.dart';
import 'package:e_commerce/Models/Order.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Models/User.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../Models/Carrito.dart';
import '../Models/Componente.dart';
import '../Models/Faq.dart';
import '../Models/MunicipioModelResponse.dart';
import '../Models/Pais.dart';
import '../Models/ProductoModelResponse.dart';
import 'package:http/http.dart' as http;

class Config {
  static late List<Municipio> municipios;
  static late List<Componente> carrito;
  static late List<ProductoAct> wishlist;
  static late List<ProductoAct> AllProducts;
  static late List<Destinatario> destinatarios;
  static late List<Categoria> categories;
  static late List<Subcategoria> subcategories;
  static late List<String> munNames;
  static late List<String> categorias;
  static late List<String> destinos;
  static late List<String> paises;
  static late List<Componente> componentes;
  static late List<Provincia> provincias;
  static late List<Orden> ordenes;
  static late List<Pais> paisesT;
  static late List<FAQ> faqs;

  static List<Componente_Carrito> comp_cart = [];

  static List locals = [
    {'name': 'EN', 'locale': Locale('en', 'US')},
    {'name': 'ES', 'locale': Locale('es', 'ES')}
  ];

  static List<ComponentePaypal> karrito = [];

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
  static String currentPW = "";
  static String? selectedCar;
  static String language = "es-es";
  static String currency = "USD";
  static String provincia = "La Habana";
  static List<String> currencies = ["USD", "CAD", "EUR"];
  static String apiURL = "https://www.diplomarket.com";
  static String token = 'token 07e3d4a91f7098ad03ab59eede7f5f29a2728a20';
  static bool login = false;
  static int mun = 1;
  static int pais = 1;
  static int destiny = 0;

  static bool internet = true;
  static bool lang = true;

  static Carrito kart = Carrito();

  static late Promocion promo;

  static const maincolor = Color.fromARGB(255, 177, 32, 36);
  static const secondarycolor = Color.fromARGB(255, 27, 39, 79);
  static int get activePais => mun;
  static int get activeMun => mun;
  static int get activeDest => destiny;
  static bool get isLoggedIn => login;

  static late User user = User();
  static User get activeUser => user;

  Future<void> setAll() async {
    await MunicipioModelResponse().getMunicipios().then((value) {
      municipios = value;
      municipios.forEach((element) {
        if (!munNames.contains(element.nombre)) munNames.add(element.nombre!);
      });
    });
    CategoriaModelResponse().getCategorias().then((value) => {
          if (categories.isNotEmpty)
            {
              categories.forEach((element) {
                if (!categorias.contains(element.nombre!))
                  categorias.add(element.nombre!);
              }),
              if (!categorias.contains("Todas")) {categorias.add("Todas")}
            }
        });
    PaisRequest().getPaises();
    print('carrito: ${kart.pk}}');
    await Componente_Carrito().getCompCart().then((value) => comp_cart = value);

    comp_cart.forEach((element) {

    });

    faqs = await FAQModelResponse().getFAQ();
    // print("Municipios: "+municipios.length.toString());
  }

  updateCarrito() async{

    await Componente_Carrito().getCompCart().then((value) => comp_cart = value);


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

  setActiveMunIndex() {
    for (int i = 0; i < municipios.length; i++) {
      if (municipios[i].nombre! == selectedMun) {
        mun = i;
      }
    }
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

  double getProductFinalPrice(ProductoAct p) {
    if (p.promocion!.activo != null) {
      if (p.promocion!.activo!) {
        return double.parse(p.precio!.cantidad!) *
            p.promocion!.descuento! /
            100;
      } else if (p.precio != null) {
        return double.parse(p.precio!.cantidad!);
      }
    }
    return double.parse(p.precio!.cantidad!);
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
      total += element.respaldo!;
    });
    total = double.parse(total.toStringAsFixed(2));

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

  List<ProductoAct> getProductosCarrito() {
    List<ProductoAct> listado = [];
    carrito.forEach((element) {
      listado.add(getProductoLocal(element));
    });
    return listado;
  }

  ProductoAct getProductoLocal(Componente c) {
    ProductoAct pro = ProductoAct();
    AllProducts.forEach((element) {
      if (c.producto == element.id) {
        pro = element;
      }
    });
    return pro;
  }

  double getRespaldo(ProductoAct prod) {
    // print(prod.id);
    return getProductFinalPrice(prod);
  }

  bool inCarrito(ProductoAct producto) {
    bool inKart = false;
    carrito.forEach((element) {
      if (element.producto == producto.id) {
        inKart = true;
      }
    });
    return inKart;
  }

  bool inWishlist(ProductoAct producto) {
    bool inWL = false;
    wishlist.forEach((element) {
      if (element.id == producto.id) {
        inWL = true;
      }
    });
    return inWL;
  }

  Destinatario getDestinatario() {
    Destinatario d = Destinatario();
    destinatarios.forEach((element) {
      if (element.nombre == destinos[destiny]) {
        d = element;
      }
    });
    return d;
  }

  void reducirInventario() {
    print("entered reducir");
    carrito.forEach((element) {
      getProductoLocal(element).substractAmmount(element.cantidad!);
    });
    carrito.clear();
    karrito.clear();
  }

  Items addToCarritoPaypal() {
    bool exists = false;
    ComponentePaypal cp = ComponentePaypal();
    carrito.forEach((element) {
      ComponentePaypal cp = ComponentePaypal(
          name: getProductoLocal(element).nombre,
          currency: currency,
          price: getProductoLocal(element).precio!.cantidad,
          quantity: element.cantidad.toString());
      // print(cp.toJson());
      karrito.forEach((e) {
        if (e.name == cp.name) {
          exists = true;
          print("existe");
        }
      });
      if (!exists) {
        karrito.add(cp);
      }
      exists = false;
    });
    CarritoPayPal paypalkart = CarritoPayPal();
    paypalkart.items = karrito;
    Items i = Items(items: karrito);
    print(i.toJson());
    return i;
  }

  validateKart() {}

  List<ProductoAct> filter(String key, int type) {
    List<ProductoAct> list = [];

    AllProducts.forEach((element) {
      switch (type) {
        case 1:
          {
            if (element.marca!.nombre == key) list.add(element);
            break;
          }
        case 2:
          {
            if (element.proveedor!.nombre == key) list.add(element);
            break;
          }
        // case 3:
        //   {
        //     if (element == key) list.add(element);
        //     break;
        //   }
        default:
          break;
      }
    });
    return list;
  }

  sendCart() {}

  sendCheckout() async {}
}
