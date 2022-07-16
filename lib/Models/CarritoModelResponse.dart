import 'dart:convert';

import 'package:e_commerce/Models/Carrito.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:http/http.dart' as http;

class CarritoModelResponse {
  Future<void> getCarrito() async {
    var headersList = {'Authorization': Config.token};
    var url = Uri.parse(Config.apiURL + Config.kartAPI);

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    CarritoRequest cr = CarritoRequest.fromJson(jsonDecode(resBody));
    var c = Carrito();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      cr.results!.forEach((element) {
        if (element.user == Config.activeUser.id && Config.carrito == null) {
          // Config.carrito = element.componentes!;
        }
      });
      // print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }

  Future<void> CreateCarrito() async {
    var headersList = {
      'Authorization': Config.token,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse(Config.apiURL + Config.kartAPI);
    var body;
    var resBody = "";
    var res;
    if (Config.isLoggedIn) {
      body = {"user": Config.activeUser.id};
    }
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);
    res = await req.send();
    resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }
}
