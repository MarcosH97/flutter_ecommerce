import 'dart:convert';

import 'package:e_commerce/Models/Municipio.dart';

class ProductoRequest {
  int? count;
  String? next;
  String? previous;
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
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Producto {
  int? id;
  String? nombre;
  String? precio;
  String? precioLb;
  String? imgPrincipal;
  Proveedor? proveedor;
  Marca? marca;
  Subcategoria? subcategoria;
  String? descripcion;
  List<Municipio>? municipios;
  int? cantidadInventario;
  List<Etiquetas>? etiquetas;
  String? slug;
  bool? visible;
  int? ventas;
  String? sku;
  String? upc;
  Promocion? promocion;
  List<String>? galeria;

  Producto(
      {this.id,
      this.nombre,
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

  Producto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    precio = json['precio'];
    precioLb = json['precio_lb'];
    imgPrincipal = json['img_principal'];
    proveedor = json['proveedor'] != null
        ? new Proveedor.fromJson(json['proveedor'])
        : null;
    marca = json['marca'] != null ? new Marca.fromJson(json['marca']) : null;
    subcategoria = json['subcategoria'] != null
        ? new Subcategoria.fromJson(json['subcategoria'])
        : null;
    descripcion = json['descripcion'];
    if (json['municipios'] != null) {
      municipios = <Municipio>[];
      json['municipios'].forEach((v) {
        municipios!.add(new Municipio.fromJson(v));
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
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['precio'] = this.precio;
    data['precio_lb'] = this.precioLb;
    data['img_principal'] = this.imgPrincipal;
    if (this.proveedor != null) {
      data['proveedor'] = this.proveedor!.toJson();
    }
    if (this.marca != null) {
      data['marca'] = this.marca!.toJson();
    }
    if (this.subcategoria != null) {
      data['subcategoria'] = this.subcategoria!.toJson();
    }
    data['descripcion'] = this.descripcion;
    if (this.municipios != null) {
      data['municipios'] = this.municipios!.map((v) => v.toJson()).toList();
    }
    data['cantidad_inventario'] = this.cantidadInventario;
    if (this.etiquetas != null) {
      data['etiquetas'] = this.etiquetas!.map((v) => v.toJson()).toList();
    }
    data['slug'] = this.slug;
    data['visible'] = this.visible;
    data['ventas'] = this.ventas;
    data['sku'] = this.sku;
    data['upc'] = this.upc;
    if (this.promocion != null) {
      data['promocion'] = this.promocion!.toJson();
    }
    if (this.galeria != null) {
      data['galeria'] = this.galeria!.map((v) => v).toList();
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
    data['id'] = this.id;
    data['nombre'] = this.nombre;
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
    data['id'] = this.id;
    if (this.etiquetas != null) {
      data['etiquetas'] = this.etiquetas!.map((v) => v.toJson()).toList();
    }
    data['nombre'] = this.nombre;
    data['categoria'] = this.categoria;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['etiqueta'] = this.etiqueta;
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
    regalo =
        json['regalo'] != null ? new Regalo.fromJson(json['regalo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this.nombre;
    data['activo'] = this.activo;
    data['descuento'] = this.descuento;
    data['entrega_gratis'] = this.entregaGratis;
    if (this.regalo != null) {
      data['regalo'] = this.regalo!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cant_compra'] = this.cantCompra;
    data['cant_regalo'] = this.cantRegalo;
    return data;
  }
}

class Componente {
  int? id;
  Producto? producto;
  int? cantidad;
  String? respaldo;
  String? orden;

  Componente(
      {this.id, this.producto, this.cantidad, this.respaldo, this.orden});

  Componente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    producto = json['producto'] != null
        ? new Producto.fromJson(json['producto'])
        : null;
    cantidad = json['cantidad'];
    respaldo = json['respaldo'];
    orden = json['orden'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.producto != null) {
      data['producto'] = this.producto!.toJson();
    }
    data['cantidad'] = this.cantidad;
    data['respaldo'] = this.respaldo;
    data['orden'] = this.orden;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    return data;
  }
}
