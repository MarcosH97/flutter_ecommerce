import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Utils/Config.dart';

class Pais {
  int? id;
  String? nombre;

  Pais({this.id, this.nombre});

  Pais.fromJson(Map<String, dynamic> json) {
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

class PaisRequest {
  Future<void> getPaises() async {
    var headersList = {'Authorization': Config.token};
    var url = Uri.parse('https://www.diplomarket.com/backend/pais/');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<dynamic> paises = jsonDecode(resBody)['results'];
      // print(paises[0].nombre);
      paises.forEach((element) {
        Pais p = Pais.fromJson(element);
        if (!Config.paisesT.contains(p)) Config.paisesT.add(p);
      });
      // print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }
}

class Provincia {
  int? id;
  String? nombre;
  int? pais;

  Provincia({this.id, this.nombre, this.pais});

  Provincia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    pais = json['pais'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['pais'] = this.pais;
    return data;
  }
}

class ProvinciaRequest {
  Future<void> getProvincias() async {
    var headersList = {'Authorization': Config.token};
    var url = Uri.parse('https://www.diplomarket.com/backend/provincia/');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      Config.provincias = List.from(jsonDecode(resBody).results);
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }
}
