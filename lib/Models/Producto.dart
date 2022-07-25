import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_commerce/Models/Municipio.dart';
import 'package:e_commerce/Utils/Config.dart';

class ProductoRec {
  String? id;
  String? nombre;
  Precio? precio;
  Precio? precioxlibra;
  String? imgPrincipal;
  Proveedor? proveedor;
  Proveedor? marca;
  String? descripcion;
  String? cantInventario;
  Etiquetas? etiquetas;
  String? slug;
  bool? visible;
  int? ventas;
  Promocion? promocion;
  List<String>? galeria;

  ProductoRec(
      {this.id,
      this.nombre,
      this.precio,
      this.precioxlibra,
      this.imgPrincipal,
      this.proveedor,
      this.marca,
      this.descripcion,
      this.cantInventario,
      this.etiquetas,
      this.slug,
      this.visible,
      this.ventas,
      this.promocion,
      this.galeria});

  ProductoRec.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    precio =
        json['precio'] != null ? new Precio.fromJson(json['precio']) : null;
    precioxlibra = json['precioxlibra'] != null
        ? new Precio.fromJson(json['precioxlibra'])
        : null;
    imgPrincipal = json['img_principal'];
    proveedor = json['proveedor'] != null
        ? new Proveedor.fromJson(json['proveedor'])
        : null;
    marca =
        json['marca'] != null ? new Proveedor.fromJson(json['marca']) : null;
    descripcion = json['descripcion'];
    // municipios = json['municipios'] != null
    //     ? new Municipios.fromJson(json['municipios'])
    //     : null;
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
    data['img_principal'] = this.imgPrincipal;
    if (this.proveedor != null) {
      data['proveedor'] = this.proveedor!.toJson();
    }
    if (this.marca != null) {
      data['marca'] = this.marca!.toJson();
    }
    data['descripcion'] = this.descripcion;
    // if (this.municipios != null) {
    //   data['municipios'] = this.municipios!.toJson();
    // }
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
    if (galeria != null) {
      data['galeria'] = galeria!.map((v) => v).toList();
    }
    return data;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cantidad'] = cantidad;
    data['moneda'] = moneda;
    return data;
  }
}

class Proveedor {
  int? id;
  String? nombre;

  Proveedor({this.id, this.nombre});

  Proveedor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
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
    id = json['id'];
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['nombre'] = nombre;
    return data;
  }
}

class ProductoSec {
  List<ProductoAct>? data;

  ProductoSec({this.data});

  ProductoSec.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      data = <ProductoAct>[];
      json['results'].forEach((v) {
        data!.add(new ProductoAct.fromJson(v));
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

class ProductoAct {
  String? id;
  String? nombre;
  Precio? precio;
  Precio? precioxlibra;
  String? um;
  String? imgPrincipal;
  Proveedor? proveedor;
  Proveedor? marca;
  String? descripcion;
  List<municipio>? municipios;
  String? cantInventario;
  Etiquetas? etiquetas;
  String? slug;
  bool? visible;
  int? ventas;
  Promocion? promocion;
  List<String>? galeria;

  ProductoAct(
      {this.id,
      this.nombre,
      this.precio,
      this.precioxlibra,
      this.um,
      this.imgPrincipal,
      this.proveedor,
      this.marca,
      this.descripcion,
      this.municipios,
      this.cantInventario,
      this.etiquetas,
      this.slug,
      this.visible,
      this.ventas,
      this.promocion,
      this.galeria});

  ProductoAct.fromJson(Map<String, dynamic> json) {
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
    marca =
        json['marca'] != null ? new Proveedor.fromJson(json['marca']) : null;
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
  Future<List<ProductoAct>> FilteredList(String key, String? subkey) async {
    List<ProductoAct> filtrado = [];
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
      List<dynamic> body;

      if (subkey != null) {
        body = jsonDecode(resBody)['$key']['$subkey'];
      } else {
        switch (key) {
          case "Aceites":
            {
              subkey = "Pomos";
              break;
            }

          case "Bebidas":
            {
              subkey = "Aguas";
              break;
            }
          default:
            {}
        }
        body = jsonDecode(resBody)['$key']['$subkey'];
        print(body);
      }
      body.forEach((element) {
        filtrado.add(ProductoAct.fromJson(element));
      });
      print(filtrado);
    } else {
      print(res.reasonPhrase);
    }
    return filtrado;
  }
}
