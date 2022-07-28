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
  String? resumenPago;
  String? total;
  int? user;
  int? destinatario;
  String? componente;
  String? currency;
  String? tipo;

  Orden({
    this.uuid,
    this.fechaCreada,
    this.resumenPago,
    this.total,
    this.user,
    this.destinatario,
    this.componente,
    this.currency,
    this.tipo,
  });

  Orden.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    fechaCreada = json['fecha_creada'];
    resumenPago = json['resumen_pago'];
    total = json['total'];
    user = json['user'];
    destinatario = json['destinatario'];
    componente = json['componente'];
    currency = json['currency'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['fecha_creada'] = this.fechaCreada;
    data['resumen_pago'] = this.resumenPago;
    data['total'] = this.total;
    data['user'] = this.user;
    data['destinatario'] = this.destinatario;
    data['componente'] = this.componente;
    data['currency'] = this.currency;
    data['tipo'] = this.tipo;
    return data;
  }
}

class OrdenRequest {
  Future<void> createOrderPayPal() async {
    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('https://www.diplomarket.com/backend/checkout/');

    var body = {
      "fecha_creada": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      "resumen_pago": "",
      "total": '4.55',
      "user": Config.activeUser.id,
      "precio_envio": 0,
      "destinatario": Config.activeDest,
      "componente": jsonEncode(Config.carrito).replaceAll(r'\"', "'"),
      "currency": Config.currency,
      "tipo": 'paypal',
    };
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print("SUCCESS");
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }

  Future<void> createOrderTropiPay() async {
    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('https://www.diplomarket.com/backend/orden/');

    var body = {
      "uuid": Uuid().v4(),
      "fecha_creada": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      "destinatario": Config.activeDest,
      "currency": Config.currency,
      "status": "",
      "comerciante": "",
      "comprador": "",
      "enlace": ""
    };
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
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
  
    if(precio_envio != null){
      result.addAll({'precio_envio': precio_envio});
    }
    if(uuid != null){
      result.addAll({'uuid': uuid});
    }
    if(status != null){
      result.addAll({'status': status});
    }
    if(currency != null){
      result.addAll({'currency': currency});
    }
    if(comerciante != null){
      result.addAll({'comerciante': comerciante});
    }
    if(comprador != null){
      result.addAll({'comprador': comprador});
    }
    if(enlace != null){
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

  factory OrderPaypal.fromJson(String source) => OrderPaypal.fromMap(json.decode(source));
}

