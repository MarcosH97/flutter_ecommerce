import 'dart:convert';

import 'package:e_commerce/Models/Producto.dart';

class ProductoRequest {
  int? count;
  String? next;
  Null? previous;
  List<Producto>? results;

  ProductoRequest({this.count, this.next, this.previous, this.results});

  ProductoRequest.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Producto>[];
      json['results'].forEach((v) {
        results!.add(new Producto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Producto {
  String? nombre;
  String? precio;
  String? precioLb;
  String? imgPrincipal;
  Proveedor? proveedor;
  Proveedor? marca;
  Subcategoria? subcategoria;
  String? descripcion;
  List<Municipios>? municipios;
  int? cantidadInventario;
  List<Etiquetas>? etiquetas;
  String? slug;
  bool? visible;
  int? ventas;
  Null? sku;
  Null? upc;
  Promocion? promocion;
  List<String>? galeria;

  Producto(
      {this.nombre,
      this.precio,
      this.precioLb,
      this.imgPrincipal,
      this.proveedor,
      this.marca,
      this.subcategoria,
      this.descripcion,
      this.municipios,
      this.cantidadInventario,
      this.etiquetas,
      this.slug,
      this.visible,
      this.ventas,
      this.sku,
      this.upc,
      this.promocion,
      this.galeria});

  void minusInv() {
    cantidadInventario!-1;
  }

  void plusInv() {}

  Producto.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    precio = json['precio'];
    precioLb = json['precio_lb'];
    imgPrincipal = json['img_principal'];
    proveedor = json['proveedor'] != null
        ? new Proveedor.fromJson(json['proveedor'])
        : null;
    marca =
        json['marca'] != null ? new Proveedor.fromJson(json['marca']) : null;
    subcategoria = json['subcategoria'] != null
        ? new Subcategoria.fromJson(json['subcategoria'])
        : null;
    descripcion = json['descripcion'];
    if (json['municipios'] != null) {
      municipios = <Municipios>[];
      json['municipios'].forEach((v) {
        municipios!.add(new Municipios.fromJson(v));
      });
    }
    cantidadInventario = json['cantidad_inventario'];
    if (json['etiquetas'] != null) {
      etiquetas = <Etiquetas>[];
      json['etiquetas'].forEach((v) {
        etiquetas!.add(new Etiquetas.fromJson(v));
      });
    }
    slug = json['slug'];
    visible = json['visible'];
    ventas = json['ventas'];
    sku = json['sku'];
    upc = json['upc'];
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
    data['nombre'] = nombre;
    data['precio'] = precio;
    data['precio_lb'] = precioLb;
    data['img_principal'] = imgPrincipal;
    if (proveedor != null) {
      data['proveedor'] = proveedor!.toJson();
    }
    if (marca != null) {
      data['marca'] = marca!.toJson();
    }
    if (subcategoria != null) {
      data['subcategoria'] = subcategoria!.toJson();
    }
    data['descripcion'] = descripcion;
    if (municipios != null) {
      data['municipios'] = municipios!.map((v) => v.toJson()).toList();
    }
    data['cantidad_inventario'] = cantidadInventario;
    if (etiquetas != null) {
      data['etiquetas'] = etiquetas!.map((v) => v.toJson()).toList();
    }
    data['slug'] = slug;
    data['visible'] = visible;
    data['ventas'] = ventas;
    data['sku'] = sku;
    data['upc'] = upc;
    if (promocion != null) {
      data['promocion'] = promocion!.toJson();
    }
    if (galeria != null) {
      data['galeria'] = galeria!.map((v) => v).toList();
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['nombre'] = nombre;
    return data;
  }
}

class Subcategoria {
  int? id;
  List<Etiquetas>? etiquetas;
  String? nombre;
  int? categoria;

  Subcategoria({this.id, this.etiquetas, this.nombre, this.categoria});

  Subcategoria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['etiquetas'] != null) {
      etiquetas = <Etiquetas>[];
      json['etiquetas'].forEach((v) {
        etiquetas!.add(new Etiquetas.fromJson(v));
      });
    }
    nombre = json['nombre'];
    categoria = json['categoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    if (etiquetas != null) {
      data['etiquetas'] = etiquetas!.map((v) => v.toJson()).toList();
    }
    data['nombre'] = nombre;
    data['categoria'] = categoria;
    return data;
  }
}

class PromoRequest {
  int? count;
  String? next;
  String? previous;
  List<Promocion>? results;

  PromoRequest({this.count, this.next, this.previous, this.results});

  PromoRequest.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Promocion>[];
      json['results'].forEach((v) {
        results!.add(new Promocion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Promocion {
  int? id;
  String? nombre;
  bool? activo;

  Promocion({this.id, this.nombre, this.activo});

  Promocion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    activo = json['activo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['activo'] = this.activo;
    return data;
  }
}
