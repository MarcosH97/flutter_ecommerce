// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:e_commerce/Models/Carrito.dart';
import 'package:e_commerce/Models/Destinatario.dart';

import '../Utils/Config.dart';

class Orden {
  String? uuid;
  String? fechaCreada;
  String? destinatario;
  double? total;
  String? currency;
  String? status;
  String? comerciante;
  String? comprador;
  String? enlace;
  double? precioEnvio;
  String? tipo;
  int? user;

  Orden(
      {this.uuid,
      this.fechaCreada,
      this.destinatario,
      this.total,
      this.currency,
      this.status,
      this.comerciante,
      this.comprador,
      this.enlace,
      this.precioEnvio,
      this.tipo,
      this.user});

  Orden.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    fechaCreada = json['fecha_creada'];
    destinatario = json['destinatario'];
    total = json['total'];
    currency = json['currency'];
    status = json['status'];
    comerciante = json['comerciante'];
    comprador = json['comprador'];
    enlace = json['enlace'];
    precioEnvio = json['precio_envio'];
    tipo = json['tipo'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['fecha_creada'] = this.fechaCreada;
    data['destinatario'] = this.destinatario;
    data['total'] = this.total;
    data['currency'] = this.currency;
    data['status'] = this.status;
    data['comerciante'] = this.comerciante;
    data['comprador'] = this.comprador;
    data['enlace'] = this.enlace;
    data['precio_envio'] = this.precioEnvio;
    data['tipo'] = this.tipo;
    data['user'] = this.user;
    return data;
  }
}

class OrderResponse {
  Future<void> getOrders() async {
    List<Orden> orders = [];

    var headersList = {'Authorization': Config.token};
    var url = Uri.parse('https://www.diplomarket.com/backend/orden/');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<dynamic> body = jsonDecode(resBody)['results'];
      body.forEach((element) {
        Orden o = Orden.fromJson(element);
        if (o.user == Config.user.id) {
          orders.add(o);
        }
      });

      Config.ordenes = orders;
      // print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }
}

class OrderPaypal {
  String? precio_envio;
  String? uuid;
  String? status;
  String? currency;
  String? comerciante;
  String? comprador;
  String? enlace;

  OrderPaypal({
    this.precio_envio,
    this.uuid,
    this.status,
    this.currency,
    this.comerciante,
    this.comprador,
    this.enlace,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (precio_envio != null) {
      result.addAll({'precio_envio': precio_envio});
    }
    if (uuid != null) {
      result.addAll({'uuid': uuid});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (currency != null) {
      result.addAll({'currency': currency});
    }
    if (comerciante != null) {
      result.addAll({'comerciante': comerciante});
    }
    if (comprador != null) {
      result.addAll({'comprador': comprador});
    }
    if (enlace != null) {
      result.addAll({'enlace': enlace});
    }

    return result;
  }

  factory OrderPaypal.fromMap(Map<String, dynamic> map) {
    return OrderPaypal(
      precio_envio: map['precio_envio'],
      uuid: map['uuid'],
      status: map['status'],
      currency: map['currency'],
      comerciante: map['comerciante'],
      comprador: map['comprador'],
      enlace: map['enlace'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderPaypal.fromJson(String source) =>
      OrderPaypal.fromMap(json.decode(source));
}
