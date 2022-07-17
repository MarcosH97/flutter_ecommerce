import 'dart:convert';

import 'package:e_commerce/Models/Categoria.dart';
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
}
