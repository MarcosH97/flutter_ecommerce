import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_commerce/Models/Municipio.dart';
import 'package:e_commerce/Utils/Config.dart';

class Producto {
  String? id;
  String? nombre;
  double? precio;
  String? precioCurrency;
  double? precioxlibra;
  String? precioxlibraCurrency;
  String? um;
  String? imgPrincipal;
  Proveedor? proveedor;
  Marca? marca;
  int? max;
  String? descripcion;
  List<municipio>? municipios;
  String? cantInventario;
  Etiquetas? etiquetas;
  String? upc;
  String? sku;
  String? subcategoria;
  Promocion? promocion;
  List<String>? galeria;
  String? slug;

  Producto(
      {this.id,
      this.nombre,
      this.precio,
      this.precioCurrency,
      this.precioxlibra,
      this.precioxlibraCurrency,
      this.um,
      this.imgPrincipal,
      this.proveedor,
      this.marca,
      this.max,
      this.descripcion,
      this.municipios,
      this.cantInventario,
      this.etiquetas,
      this.upc,
      this.sku,
      this.subcategoria,
      this.promocion,
      this.galeria,
      this.slug});

  Producto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    precio = json['precio'];
    precioCurrency = json['precio_currency'];
    precioxlibra = json['precioxlibra'];
    precioxlibraCurrency = json['precioxlibra_currency'];
    um = json['um'];
    imgPrincipal = json['img_principal'];
    proveedor = json['proveedor'] != null
        ? new Proveedor.fromJson(json['proveedor'])
        : null;
    marca = json['marca'] != null ? new Marca.fromJson(json['marca']) : null;
    max = json['max'];
    descripcion = json['descripcion'];
    if (json['municipios'] != null) {
      municipios = <municipio>[];
      json['municipios'].forEach((v) {
        municipios!.add(new municipio.fromJson(v));
      });
    }
    cantInventario = json['cant_inventario'];
    etiquetas = json['etiquetas'] != null
        ? new Etiquetas.fromJson(json['etiquetas'])
        : null;
    upc = json['upc'];
    sku = json['sku'];
    subcategoria = json['subcategoria'];
    promocion = json['promocion'] != null
        ? new Promocion.fromJson(json['promocion'])
        : null;
    galeria = json['galeria'].cast<String>();
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['precio'] = this.precio;
    data['precio_currency'] = this.precioCurrency;
    data['precioxlibra'] = this.precioxlibra;
    data['precioxlibra_currency'] = this.precioxlibraCurrency;
    data['um'] = this.um;
    data['img_principal'] = this.imgPrincipal;
    if (this.proveedor != null) {
      data['proveedor'] = this.proveedor!.toJson();
    }
    if (this.marca != null) {
      data['marca'] = this.marca!.toJson();
    }
    data['max'] = this.max;
    data['descripcion'] = this.descripcion;
    if (this.municipios != null) {
      data['municipios'] = this.municipios!.map((v) => v.toJson()).toList();
    }
    data['cant_inventario'] = this.cantInventario;
    if (this.etiquetas != null) {
      data['etiquetas'] = this.etiquetas!.toJson();
    }
    data['upc'] = this.upc;
    data['sku'] = this.sku;
    data['subcategoria'] = this.subcategoria;
    if (this.promocion != null) {
      data['promocion'] = this.promocion!.toJson();
    }
    data['galeria'] = this.galeria;
    data['slug'] = this.slug;
    return data;
  }

  Future<void> substractAmmount(int cant) async {
    print("entered substract");
    int cant_inv = int.parse(cantInventario!);

    int cantFinal = cant_inv - cant;

    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('https://www.diplomarket.com/backend/producto/$id/');

    var body = {"cantidad_inventario": "$cantFinal"};
    var req = http.Request('PATCH', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print("reduces");
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }
}

class ProductoMun {
  String? id;
  String? nombre;
  Precio? precio;
  Precio? precioxlibra;
  String? um;
  String? imgPrincipal;
  Proveedor? proveedor;
  Marca? marca;
  int? max;
  String? descripcion;
  List<municipio>? municipios;
  String? cantInventario;
  Etiquetas? etiquetas;
  String? slug;
  bool? visible;
  int? ventas;
  Promocion? promocion;
  List<String>? galeria;

  ProductoMun(
      {this.id,
      this.nombre,
      this.precio,
      this.precioxlibra,
      this.um,
      this.imgPrincipal,
      this.proveedor,
      this.marca,
      this.max,
      this.descripcion,
      this.municipios,
      this.cantInventario,
      this.etiquetas,
      this.slug,
      this.visible,
      this.ventas,
      this.promocion,
      this.galeria});

  ProductoMun.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    precio =
        json['precio'] != null ? new Precio.fromJson(json['precio']) : null;
    precioxlibra = json['precioxlibra'] != null
        ? new Precio.fromJson(json['precioxlibra'])
        : null;

    um = json['um'];
    imgPrincipal = json['img_principal'];
    proveedor = json['proveedor'] != null
        ? new Proveedor.fromJson(json['proveedor'])
        : null;
    marca = json['marca'] != null ? new Marca.fromJson(json['marca']) : null;
    max = json['max'];
    descripcion = json['descripcion'];
    if (json['municipios'] != null) {
      municipios = <municipio>[];
      json['municipios'].forEach((v) {
        municipios!.add(new municipio.fromJson(v));
      });
    }
    cantInventario = json['cant_inventario'];
    etiquetas = json['etiquetas'] != null
        ? new Etiquetas.fromJson(json['etiquetas'])
        : null;
    slug = json['slug'];
    visible = json['visible'];
    ventas = json['ventas'];
    promocion = json['promocion'] != null
        ? new Promocion.fromJson(json['promocion'])
        : null;
    if (json['galeria'] != null) {
      galeria = <String>[];
      json['galeria'].forEach((v) {
        galeria!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    if (this.precio != null) {
      data['precio'] = this.precio!.toJson();
    }
    if (this.precioxlibra != null) {
      data['precioxlibra'] = this.precioxlibra!.toJson();
    }
    data['um'] = this.um;
    data['img_principal'] = this.imgPrincipal;
    if (this.proveedor != null) {
      data['proveedor'] = this.proveedor!.toJson();
    }
    if (this.marca != null) {
      data['marca'] = this.marca!.toJson();
    }
    data['max'] = this.max;
    data['descripcion'] = this.descripcion;
    if (this.municipios != null) {
      data['municipios'] = this.municipios!.map((v) => v.toJson()).toList();
    }
    data['cant_inventario'] = this.cantInventario;
    if (this.etiquetas != null) {
      data['etiquetas'] = this.etiquetas!.toJson();
    }
    data['slug'] = this.slug;
    data['visible'] = this.visible;
    data['ventas'] = this.ventas;
    if (this.promocion != null) {
      data['promocion'] = this.promocion!.toJson();
    }
    if (this.galeria != null) {
      data['galeria'] = this.galeria!.map((v) => v).toList();
    }
    return data;
  }

  Future<void> substractAmmount(int cant) async {
    print("entered substract");
    int cant_inv = int.parse(cantInventario!);

    int cantFinal = cant_inv - cant;

    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('https://www.diplomarket.com/backend/producto/$id/');

    var body = {"cantidad_inventario": "$cantFinal"};
    var req = http.Request('PATCH', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print("reduces");
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }
}

class Precio {
  String? cantidad;
  String? moneda;

  Precio({this.cantidad, this.moneda});

  Precio.fromJson(Map<String, dynamic> json) {
    cantidad = json['cantidad'];
    moneda = json['moneda'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cantidad'] = this.cantidad;
    data['moneda'] = this.moneda;
    return data;
  }
}

class Proveedor {
  int? id;
  String? nombre;

  Proveedor({this.id, this.nombre});

  Proveedor.fromJson(Map<String, dynamic> json) {
    id = json['pk'];
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['pk'] = id;
    data['nombre'] = nombre;
    return data;
  }
}

class Etiquetas {
  int? id;
  String? etiqueta;

  Etiquetas({this.id, this.etiqueta});

  Etiquetas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    etiqueta = json['etiqueta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['etiqueta'] = etiqueta;
    return data;
  }
}

class PromoRequest {
  int? count;
  Null? next;
  Null? previous;
  List<Promocion>? results;

  PromoRequest({this.count, this.next, this.previous, this.results});

  PromoRequest.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Promocion>[];
      json['results'].forEach((v) {
        results!.add(Promocion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Promocion {
  String? nombre;
  bool? activo;
  double? descuento;
  bool? entregaGratis;
  Regalo? regalo;

  Promocion(
      {this.nombre,
      this.activo,
      this.descuento,
      this.entregaGratis,
      this.regalo});

  Promocion.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    activo = json['activo'];
    descuento = json['descuento'];
    entregaGratis = json['entrega_gratis'];
    regalo = json['regalo'] != null ? Regalo.fromJson(json['regalo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nombre'] = nombre;
    data['activo'] = activo;
    data['descuento'] = descuento;
    data['entrega_gratis'] = entregaGratis;
    if (regalo != null) {
      data['regalo'] = regalo!.toJson();
    }
    return data;
  }
}

class Regalo {
  int? cantCompra;
  int? cantRegalo;

  Regalo({this.cantCompra, this.cantRegalo});

  Regalo.fromJson(Map<String, dynamic> json) {
    cantCompra = json['cant_compra'];
    cantRegalo = json['cant_regalo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cant_compra'] = cantCompra;
    data['cant_regalo'] = cantRegalo;
    return data;
  }
}

class Marca {
  int? id;
  String? nombre;

  Marca({this.id, this.nombre});

  Marca.fromJson(Map<String, dynamic> json) {
    id = json['pk'];
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['pk'] = id;
    data['nombre'] = nombre;
    return data;
  }
}

class ProductoSec {
  List<Producto>? data;

  ProductoSec({this.data});

  ProductoSec.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      data = <Producto>[];
      json['results'].forEach((v) {
        data!.add(new Producto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['results'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class municipio {
  int? pk;
  String? nombre;
  String? provincia;

  municipio({this.pk, this.nombre, this.provincia});

  municipio.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    nombre = json['nombre'];
    provincia = json['provincia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.pk;
    data['nombre'] = this.nombre;
    data['provincia'] = this.provincia;
    return data;
  }
}

class ProductoFiltro {
  Future<List<ProductoMun>> FilteredList({String? key, String? subkey}) async {
    print('key $key  subcat $subkey');

    List<String> bebidas = ['Aguas', 'Gaseadas', 'Instantáneas', 'Jugos'];
    List<String> elect = ['Electrodomesticos', 'Piezas de Pc'];
    List<ProductoMun> filtrado = [];
    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token
    };
    var url = Uri.parse(
        'https://www.diplomarket.com/backend/producto/arbol/${Config.activeMun}');
    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    // print(resBody);
    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<dynamic> body = [];
      if (key == null && subkey != null) {
        if (bebidas.contains(subkey)) {
          body = jsonDecode(resBody)['Bebidas']['$subkey'];
        } else if (elect.contains(subkey)) {
          body = jsonDecode(resBody)['Electrónicos']['$subkey'];
        } else if (subkey == 'Pomos') {
          body = jsonDecode(resBody)['Aceites']['$subkey'];
        } else {}
        body.forEach((element) {
          filtrado.add(ProductoMun.fromJson(element));
        });
        return filtrado;
      } else if (subkey != null) {
        body = jsonDecode(resBody)['$key']['$subkey'];
        body.forEach((element) {
          filtrado.add(ProductoMun.fromJson(element));
        });
      } else if (key != null && subkey == null) {
        switch (key) {
          case "Aceites":
            {
              subkey = "Pomos";
              body = jsonDecode(resBody)['$key']['$subkey'];
              body.forEach((element) {
                filtrado.add(ProductoMun.fromJson(element));
              });
              return filtrado;
            }
          case "Bebidas":
            {
              for (var s in bebidas) {
                body = jsonDecode(resBody)['$key'][s];
                body.forEach((element) {
                  filtrado.add(ProductoMun.fromJson(element));
                });
              }
              return filtrado;
            }
          case "Electrónicos":
            {
              for (var s in elect) {
                body = jsonDecode(resBody)['$key'][s];
                body.forEach((element) {
                  filtrado.add(ProductoMun.fromJson(element));
                });
              }
              return filtrado;
            }
          default:
            {}
        }
      } else {
        body = jsonDecode(resBody)[key][subkey];
        body.forEach((element) {
          filtrado.add(ProductoMun.fromJson(element));
        });
        return filtrado;
      }
    } else {
      print(res.reasonPhrase);
    }
    return filtrado;
  }
}
