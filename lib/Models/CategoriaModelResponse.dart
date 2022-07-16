import 'dart:convert';

import 'package:e_commerce/Models/Categoria.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:http/http.dart' as http;

class CategoriaModelResponse {
  Future<void> getCategorias() async {
    var headersList = {'Authorization': Config.token};
    var url = Uri.parse(Config.apiURL + Config.catAPI);

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      var cat = CategoriaRequest.fromJson(jsonDecode(resBody));

      cat.results!.forEach((element) {
        if (!Config.categories.contains(element)) {
          Config.categories.add(element);
        }
      });
    } else {
      print(res.reasonPhrase);
    }
  }
}
