import 'dart:convert';
import 'dart:ui';
import 'package:e_commerce/Models/Categoria.dart';
import 'package:e_commerce/Models/Destinatario.dart';
import 'package:e_commerce/Models/Municipio.dart';
import 'package:e_commerce/Models/Order.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Models/User.dart';
import 'package:e_commerce/Models/carrusel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../Models/Carrito.dart';
import '../Models/Componente.dart';
import '../Models/Faq.dart';
import '../Models/MunicipioModelResponse.dart';
import '../Models/Pais.dart';
import '../Models/ProductoModelResponse.dart';
import 'package:http/http.dart' as http;

import '../Providers/cartProvider.dart';

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

  static List<String> provinciaL = [];
  static List<Carrusel> carrusel = [];
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
  static List<String> currencies = ["USD", "EUR"];
  static String apiURL = "https://www.diplomarket.com";
  static String token = 'token 07e3d4a91f7098ad03ab59eede7f5f29a2728a20';
  static bool login = false;
  static int mun = 1;
  static int prov = 1;
  static int pais = 1;
  static int destiny = -1;
  static int destinIndex = 0;

  static int cantWL = 0;

  static String params = "";

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
    await CarruselResponse().getCarrusel();
    await PaisRequest().getPaises();
    await ProvinciaRequest().getProvincias(pais);
    await MunicipioModelResponse().getMunicipios().then((value) {
      municipios = value;
      municipios.forEach((element) {
        if (element.provincia == prov) if (!munNames.contains(element.nombre))
          munNames.add(element.nombre!);
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

    // print('carrito: ${kart.pk}}');

    faqs = await FAQModelResponse().getFAQ();
    // print("Municipios: "+municipios.length.toString());
  }

  updateCarrito() async {
    await Componente_Carrito().getCompCart().then((value) => comp_cart = value);
    comp_cart.forEach((element) {
      bool found = false;
      carrito.forEach((element2) {
        if (element2.producto == element.id.toString()) {
          found = true;
        }
      });
      if (!found) {
        carrito.add(Componente(
            cantidad: 1,
            producto: element.producto,
            respaldo:
                getRespaldo(findProdyctByID(element.producto.toString()))));
      }
      print("carrito: $carrito");
    });
  }

  ProductoAct findProdyctByID(id) {
    ProductoAct pa = ProductoAct();
    AllProducts.forEach((element) {
      if (element.id == id) {
        pa = element;
      }
    });
    return pa;
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
    double preciof = double.parse(p.precio!.cantidad!);
    if (p.promocion!.activo != null) {
      if (p.promocion!.activo!) {
        preciof =
            double.parse(p.precio!.cantidad!) * p.promocion!.descuento! / 100;
      }
    }
    // print(preciof);
    return preciof;
  }

  void setupDestinatarios() {
    destinatarios.forEach((element) {
      if (!destinos.contains(element.nombre)) {
        destinos.add(element.nombre!);
      }
    });
    // print("Lista dests: $destinos");
  }

  setDestinIndexes(String name) {
    for (int i = 0; i < destinos.length; i++) {
      if (name == destinos[i]) {
        destinIndex = i;
        destiny = getDestinatario().id!;
      }
    }
  }

  Destinatario getDestinatario() {
    Destinatario d = Destinatario(email: "", direccion: "", nombre: "");
    for (var element in destinatarios) {
      if (element.nombre == destinos[destinIndex]) {
        d = element;
      }
    }
    // print(d.nombre);
    return d;
  }

  double getTotalPriceKart({BuildContext? context}) {
    double total = 0;
    if (context == null) {
      carrito.forEach((element) {
        // print(element.respaldo);
        total += element.respaldo!;
      });
    } else {
      context.read<Cart>().getLista.forEach((element) {
        total += element.respaldo!;
      });
    }
    total = double.parse(total.toStringAsFixed(2));
    // print(total);
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

  List<ProductoAct> getProductosCarrito(BuildContext context) {
    List<ProductoAct> listado = [];
    carrito = context.watch<Cart>().getLista;
    carrito.forEach((element) {
      listado.add(getProductoLocal(element));
    });
    return listado;
  }

  ProductoAct getProductoLocal(Componente c) {
    ProductoAct pro = ProductoAct();
    AllProducts.forEach((element) {
      if (c.producto.toString() == element.id) {
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
          price: getProductFinalPrice(getProductoLocal(element)).toString(),
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

    Destinatario d = getDestinatario();

    ShippingAddress sa = ShippingAddress(
        recipientName: d.nombre,
        city: d.ciudad,
        countryCode: "CU",
        line1: d.direccion,
        line2: "",
        phone: d.telefono,
        postalCode: "10400",
        state: "La Habana");

    Items i = Items(items: karrito, shipping_address: sa);
    // print(i.toJson());
    return i;
  }

  bool validateKart() {
    print('entered validation');
    bool b = false;
    kart.componentes!.forEach((element) async {
      ProductoAct futuro = await getProducto(element.producto!.id!);
      if (int.parse(element.cantidad!) <= int.parse(futuro.cantInventario!)) {
        print('validated');
        b = true;
      }
    });
    return b;
  }

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

  Future<List<String>> searchBar(String key) async {
    List<String> lista = [];
    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse(
        'https://www.diplomarket.com/backend/buscar/${Config.activeMun}/$key');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<dynamic> body = jsonDecode(resBody);

      body.forEach((element) {
        lista.add(element['nombre']);
      });
      print(resBody);
      return lista;
    } else {
      print(res.reasonPhrase);
      return lista;
    }
  }

  int getMunicipioID(String name) {
    int id = -1;
    for (Municipio m in municipios) {
      if (m.nombre == name) {
        id = m.id!;
      }
    }

    return id;
  }

  int getPaisID(String name) {
    int id = -1;
    for (Pais m in paisesT) {
      if (m.nombre == name) {
        id = m.id!;
      }
    }
    return id;
  }

  int getProvinciaID(String name) {
    int id = -1;
    for (Provincia m in provincias) {
      if (m.nombre == name) {
        id = m.id!;
      }
    }
    return id;
  }

  List<DataRow> getOrdenes() {
    List<DataRow> dc = [];
    ordenes.forEach((element) {
      dc.add(DataRow(cells: [
        if (element.tipo == 'paypal')
          DataCell(Padding(
            padding: const EdgeInsets.all(2.0),
            child: SizedBox(width: 50, child: Image.asset('assets/paypal.png')),
          ))
        else
          DataCell(Padding(
            padding: const EdgeInsets.all(2.0),
            child: SizedBox(width: 50, child: Image.asset('assets/tropi.png')),
          )),
        DataCell(Text(element.uuid!)),
        DataCell(Text(element.status!)),
        DataCell(Text(element.fechaCreada!))
      ]));
    });

    return dc;
  }

  LoadUserData() {
    DestinatarioResponse().getDestinatarios();
    OrderResponse().getOrders();
  }
}
