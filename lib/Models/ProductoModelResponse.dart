import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Models/Producto2.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ProductoModelResponse {
  Future<ProductoRequest> getProductList() async {
    var headersList = {
      'Authorization': Config.token
    };
    var url = Uri.parse(Config.apiURL+Config.productAPI);

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final ProductoRequest body =
          ProductoRequest.fromJson(jsonDecode(resBody));
      return body;
    } else {
      print(res.reasonPhrase);
      // print("error");
      throw Exception();
    }
  }

  Future<List<ProductoRequest>> getProductoRequest(http.Client client) async {
    final response =
        await client.get(Uri.parse(Config.apiURL+Config.productAPI));

    return compute(parseProductsReq, response.body);
  }

  List<ProductoRequest> parseProductsReq(String respBody) {
    final parsed = jsonDecode(respBody).cast<Map<String, dynamic>>();

    return parsed
        .map<ProductoRequest>((json) => ProductoRequest.fromJson(json))
        .toList();
  }
}
