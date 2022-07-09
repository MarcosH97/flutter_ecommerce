import 'dart:convert';

import 'package:e_commerce/Models/Producto2.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:http/http.dart' as http;

class PromoModelResponse {
  Future<Promocion> getPromo() async {
    var headersList = {'Authorization': Config.token};
    var url = Uri.parse(Config.apiURL + Config.promoAPI);

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final PromoRequest body = PromoRequest.fromJson(jsonDecode(resBody));
      return body.results![0];
    } else {
      print(res.reasonPhrase);
      return Promocion();
    }
  }
}
