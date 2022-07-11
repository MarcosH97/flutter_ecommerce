import 'package:e_commerce/Models/Municipio.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ProductoModelResponse {
  Future<ProductoRequest> getProductList() async {
    var headersList = {'Authorization': Config.token};
    var url = Uri.parse(Config.apiURL + Config.productAPI);

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      var body = ProductoRequest.fromJson(jsonDecode(resBody));
      // print(body);
      // print(body.results![0].municipios![0].nombre);
      return body;
    } else {
      print(res.reasonPhrase);
      // print("error");
      throw Exception();
    }
  }

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
