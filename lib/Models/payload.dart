import 'dart:convert';

import 'package:e_commerce/Models/Destinatario.dart';
import 'package:e_commerce/Models/Order.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../Utils/Config.dart';

class Payload {
  String? date;
  String? total;
  String? user;
  String? destinatario;
  OrderPaypal? order;

  Future<void> sendPayload(String tipo) async {
    var dformat = DateFormat("yyyy-MM-dd HH:mm:ss");
    date = dformat.format(DateTime.now());
    print(date);
    var uuid = Uuid();
    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('https://www.diplomarket.com/backend/apk/checkout/');
    var body;
    if (tipo == "paypal") {
      body = {
        "uuid": uuid.v4(),
        "status": "COMPLETED",
        "currency": Config.currency,
        "enlace": "dasdasd",
        "fecha_creada": date,
        "total": Config().getTotalPriceKart().toString(),
        "user": Config.user.id.toString(),
        "destinatario": Config.destiny.toString(),
        "precio_envio": Config().getCostActiveMun().toString(),
        "tipo": "paypal",
        "componente": jsonEncode(Config.carrito)
            .replaceAll(r'\"', "'")
            .replaceAll('"', '')
      };
    } else {
      body = {
        "uuid": uuid.v4(),
        "status": "COMPLETED",
        "currency": Config.currency,
        "enlace": "dasdasd",
        "fecha_creada": date,
        "total": Config().getTotalPriceKart().toString(),
        "user": Config.user.id.toString(),
        "destinatario": Config.destiny.toString(),
        "precio_envio": Config().getCostActiveMun().toString(),
        "tipo": "tropipay"
      };
    }
    print("Body: $body");
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

  Future<void> sendPayload2(String status, String link) async {
    // print();
    var dformat = DateFormat("yyyy-MM-dd HH:mm:ss");
    date = dformat.format(DateTime.now());
    print(date);
    var uuid = Uuid();
    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('https://www.diplomarket.com/backend/apk/checkout/');
    var body = {
      "uuid": uuid.v4(),
      "status": status,
      "currency": Config.currency,
      "enlace": link,
      "fecha_creada": date,
      "total": Config().getTotalPriceKart().toString(),
      "user": Config.activeUser.id.toString(),
      "destinatario": Config.activeDest.toString(),
      "precio_envio": Config().getCostActiveMun().toString(),
      "tipo": "paypal",
      "componente":
          jsonEncode(Config.carrito).replaceAll(r'\"', "'").replaceAll('"', '')
    };

    print("Body: $body");
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

  Future<bool> sendTropiload() async {
    // print();
    var dformat = DateFormat("yyyy-MM-dd HH:mm:ss");
    date = dformat.format(DateTime.now());
    // print(date);
    var uuid = Uuid();
    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('https://www.diplomarket.com/backend/apk/checkout/');
    var body = {
      "uuid": uuid.v4(),
      "currency": Config.currency,
      "fecha_creada": date,
      "total": Config().getTotalPriceKart().toString(),
      "user": Config.activeUser.id.toString(),
      "destinatario": Config.activeDest.toString(),
      "precio_envio": Config().getCostActiveMun().toString(),
      "tipo": "tropipay",
      "componente":
          jsonEncode(Config.carrito).replaceAll(r'\"', "'").replaceAll('"', '')
    };

    print("Body: $body");
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return true;
      print(resBody);
    } else {
      print(res.reasonPhrase);
      return false;
    }
  }
}
