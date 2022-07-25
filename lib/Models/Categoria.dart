import 'dart:convert';

import 'package:e_commerce/Models/Categoria.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:http/http.dart' as http;

class Categoria {
  int? id;
  String? nombre;
  bool? especial;

  Categoria({this.id, this.nombre, this.especial});

  Categoria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    especial = json['especial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['especial'] = this.especial;
    return data;
  }
}

class CategoriaModelResponse {
  Future<void> getCategorias() async {
    var headersList = {'Authorization': Config.token};
    var url = Uri.parse(Config.apiURL + Config.catAPI);

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      var cat = List.from(jsonDecode(resBody)['results']);
      cat.forEach((element) {
        Categoria c = Categoria.fromJson(element);
        if (!Config.categories.contains(c)) {
          Config.categories.add(c);
        }
      });
    } else {
      print(res.reasonPhrase);
    }
  }

  Future<void> getSubCategorias() async {
    var headersList = {'Authorization': Config.token};
    var url = Uri.parse("https://www.diplomarket.com/backend/subcategoria/");

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      var cat = List.from(jsonDecode(resBody)['results']);
      cat.forEach((element) {
        Subcategoria c = Subcategoria.fromJson(element);
        if (!Config.subcategories.contains(c)) {
          Config.subcategories.add(c);
        }
      });
    } else {
      print(res.reasonPhrase);
    }
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
        etiquetas!.add(Etiquetas.fromJson(v));
      });
    }
    nombre = json['nombre'];
    categoria = json['categoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (etiquetas != null) {
      data['etiquetas'] = etiquetas!.map((v) => v.toJson()).toList();
    }
    data['nombre'] = nombre;
    data['categoria'] = categoria;
    return data;
  }
}

