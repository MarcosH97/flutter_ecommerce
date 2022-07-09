import 'dart:convert';

import 'package:e_commerce/Models/Categoria.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:http/http.dart' as http;

class CategoriaModelResponse {
  Future<CategoriaRequest> getCategorias() async {
    var headersList = {'Authorization': Config.token};
    var url = Uri.parse(Config.apiURL + Config.catAPI);

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final CategoriaRequest cat =
          CategoriaRequest.fromJson(jsonDecode(resBody));

      // print(cat.results);
      // print(cat.results);
      return cat;
    } else {
      print(res.reasonPhrase);
      return CategoriaRequest();
    }
  }
}
