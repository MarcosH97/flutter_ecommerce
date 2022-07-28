import 'package:e_commerce/Models/Municipio.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ProductoModelResponse {
  Future<dynamic> getProductRecList() async {
    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token
    };
    var url = Uri.parse(
        'https://www.diplomarket.com/backend/producto/?municipios=${Config.activeMun}');
    // print("getting PREC");
    var req = http.Request('GET', url);
    req.headers.addAll(headersList);
    var res = await req.send().timeout(const Duration(seconds: 5));
    // print(res.statusCode);
    final resBody = await res.stream.bytesToString();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      // print(resBody);

      ProductoSec body = ProductoSec.fromJson(jsonDecode(resBody));
      List<ProductoAct>? pro = body.data;
      if (pro != null) {
        Config.AllProducts = pro;
      }
      return pro;
    } else {
      print(res.reasonPhrase);
      // print("error");
      throw Exception();
    }
  }

  Future<int> getSpecificProductStock(String id) async {
    var headersList = {
      'Authorization': Config.token,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('https://www.diplomarket.com/backend/producto/$id');
    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    int result = jsonDecode(resBody)['cant_inventario'];

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(result);
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
    return result;
  }

  Future<void> getProductTopSellList(municipioID) async {
    var headersList = {'Authorization': Config.token};
    var url = Uri.parse(Config.apiURL + Config.masvendidosAPI + "1");

    var req = http.Request('GET', url);

    req.headers.addAll(headersList);
    var res = await req.send().timeout(const Duration(seconds: 5));

    // print("Top seller status: "+ res.statusCode.toString());

    final resBody = await res.stream.bytesToString();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      var body = jsonDecode(resBody);
      List<dynamic> lista = List.from(body);
      ProductoRec pr = lista[0];

      // print(pr);
      // print(body);
      // return body;
    } else {
      print(res.reasonPhrase);
      // print("error");
      throw Exception();
    }
  }

  Future<List<ProductoAct>> getProductSpecialList() async {
    List<ProductoAct> lista = [];
    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token
    };
    var url = Uri.parse(
        'https://www.diplomarket.com/backend/producto/especiales/${Config.activeMun}');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<dynamic> body = jsonDecode(resBody);
      for(var v in body){
          lista.add(ProductoAct.fromJson(v));
      }
      // print(resBody);
    } else {
      print(res.reasonPhrase);
    }
    return lista;
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
