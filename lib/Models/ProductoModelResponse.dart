import 'package:e_commerce/Models/Municipio.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ProductoModelResponse {
  Future<List<ProductoMun>> getProductList() async {
    print('entered get prods');
    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token
    };
    var url = Uri.parse(
        'https://www.diplomarket.com/backend/producto/?municipios=${Config.activeMun}');
    var req = http.Request('GET', url);
    req.headers.addAll(headersList);
    var res = await req.send().timeout(const Duration(seconds: 5));
    final resBody = await res.stream.bytesToString();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<dynamic> pro = jsonDecode(resBody)['results'];
      // var prod = pro[0];
      List<ProductoMun> lista = [];
      pro.forEach((element) {
        lista.add(ProductoMun.fromJson(element));
      });
      Config.AllProductsMun = lista;
      return lista;
    } else {
      print(res.reasonPhrase);
      throw Exception();
    }
  }

  Future<Producto> getProductobyID(String id) async {
    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token
    };
    var url = Uri.parse('https://www.diplomarket.com/backend/producto/$id');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);
    var res = await req.send().timeout(const Duration(seconds: 5));
    final resBody = await res.stream.bytesToString();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return Producto.fromJson(jsonDecode(resBody));
    }
    return Producto();
  }

  Future<List<ProductoMun>> getProductTopSellList() async {
    List<ProductoMun> lista = [];

    var headersList = {'Authorization': Config.token};
    var url = Uri.parse(
        'https://www.diplomarket.com/backend/masvendidos/ultimahora/${Config.activeMun}');

    var req = http.Request('GET', url);

    req.headers.addAll(headersList);
    var res = await req.send().timeout(const Duration(seconds: 5));

    final resBody = await res.stream.bytesToString();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      // print('topsell: $resBody');
      List<dynamic> body = jsonDecode(resBody);
      body.forEach((element) {
        lista.add(ProductoMun.fromJson(element));
      });
      return lista;
    } else {
      print(res.reasonPhrase);
      throw Exception();
    }
  }
  Future<List<ProductoMun>> getProductRecommendedList() async {
    List<ProductoMun> lista = [];

    var headersList = {'Authorization': Config.token};
    var url = Uri.parse(
        'https://www.diplomarket.com/backend/recomendados/${Config.user.id}/${Config.activeMun}/');

    var req = http.Request('GET', url);

    req.headers.addAll(headersList);
    var res = await req.send().timeout(const Duration(seconds: 5));

    final resBody = await res.stream.bytesToString();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      // print('topsell: $resBody');
      List<dynamic> body = jsonDecode(resBody);
      body.forEach((element) {
        lista.add(ProductoMun.fromJson(element));
      });
      return lista;
    } else {
      print(res.reasonPhrase);
      throw Exception();
    }
  }

  Future<List<ProductoMun>> getProductSpecialList() async {
    List<ProductoMun> lista = [];
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
      // print('special: $resBody');
      List<dynamic> body = jsonDecode(resBody);
      for (var v in body) {
        lista.add(ProductoMun.fromJson(v));
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
