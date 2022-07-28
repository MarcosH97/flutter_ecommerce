import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Utils/Config.dart';

class DestinatarioRequest {
  int? count;
  String? next;
  String? previous;
  List<Destinatario>? results;

  DestinatarioRequest({this.count, this.next, this.previous, this.results});

  DestinatarioRequest.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Destinatario>[];
      json['results'].forEach((v) {
        results!.add(new Destinatario.fromJson(v));
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

class Destinatario {
  int? id;
  String? nombre;
  String? nombreRemitente;
  String? nombreAlternativo;
  String? apellido1;
  String? apellido2;
  String? ci;
  String? email;
  String? telefono;
  String? telefonoAlternativo;
  String? ciudad;
  String? direccion;
  String? notaEntrega;
  bool? activo;
  int? usuario;
  int? pais;
  int? provincia;
  int? municipio;

  Destinatario(
      {this.id,
      this.nombre,
      this.nombreRemitente,
      this.nombreAlternativo,
      this.apellido1,
      this.apellido2,
      this.ci,
      this.email,
      this.telefono,
      this.telefonoAlternativo,
      this.ciudad,
      this.direccion,
      this.notaEntrega,
      this.activo,
      this.usuario,
      this.pais,
      this.provincia,
      this.municipio});

  Destinatario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    nombreRemitente = json['nombre_remitente'];
    nombreAlternativo = json['nombre_alternativo'];
    apellido1 = json['apellido1'];
    apellido2 = json['apellido2'];
    ci = json['ci'];
    email = json['email'];
    telefono = json['telefono'];
    telefonoAlternativo = json['telefono_alternativo'];
    ciudad = json['ciudad'];
    direccion = json['direccion'];
    notaEntrega = json['nota_entrega'];
    activo = json['activo'];
    usuario = json['usuario'];
    pais = json['pais'];
    provincia = json['provincia'];
    municipio = json['municipio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['nombre_remitente'] = this.nombreRemitente;
    data['nombre_alternativo'] = this.nombreAlternativo;
    data['apellido1'] = this.apellido1;
    data['apellido2'] = this.apellido2;
    data['ci'] = this.ci;
    data['email'] = this.email;
    data['telefono'] = this.telefono;
    data['telefono_alternativo'] = this.telefonoAlternativo;
    data['ciudad'] = this.ciudad;
    data['direccion'] = this.direccion;
    data['nota_entrega'] = this.notaEntrega;
    data['activo'] = this.activo;
    data['usuario'] = this.usuario;
    data['pais'] = this.pais;
    data['provincia'] = this.provincia;
    data['municipio'] = this.municipio;
    return data;
  }
}

class DestinatarioResponse {
  Future<bool> createDestinatario(Destinatario d) async {
    var headersList = {
      'Authorization': Config.token,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('https://www.diplomarket.com/backend/destinatario/');

    var body = {
      "nombre": d.nombre,
      "nombre_remitente": d.nombreRemitente,
      "nombre_alternativo": d.nombreAlternativo,
      "apellido1": d.apellido1,
      "apellido2": d.apellido2,
      "ci": d.ci,
      "email": d.email,
      "telefono": d.telefono,
      "telefono_alternativo": d.telefonoAlternativo,
      "ciudad": d.ciudad,
      "direccion": d.direccion,
      "nota_entrega": d.notaEntrega,
      "usuario": d.usuario,
      "pais": d.pais,
      "provincia": d.provincia,
      "municipio": d.municipio,
      "activo": d.activo
    };
    print(body);
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      return true;
    } else {
      print(res.reasonPhrase);
      return false;
    }
  }

  Future<void> getDestinatarios() async {
    var headersList = {'Authorization': Config.token};
    var url = Uri.parse('https://www.diplomarket.com/backend/destinatario/');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    // print('llenando destinatarios');
    // print(resBody);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      var body = DestinatarioRequest.fromJson(jsonDecode(resBody));
      body.results!.forEach((element) {
        // print(element);
        if (element.usuario == Config.activeUser.id &&
            !Config.destinatarios.contains(element)) {
          Config.destinatarios.add(element);
          // Config.destinos.add(element.nombre!);
          // print(Config.destinos);
        }
      });
      Config().setupDestinatarios();
      Config().setDestinIndexes(Config.destinos[0]);
    } else {
      print(res.reasonPhrase);
    }
  }
}
