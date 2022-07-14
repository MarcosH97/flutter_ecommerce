import 'package:e_commerce/Models/Municipio.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MunicipioModelResponse {
  Future<List<Municipio>> getMunicipios() async {
    var headersList = {
      'Authorization': 'token 54cefb0aabf266f83383cec926ef5073dc156f2e'
    };
    var url = Uri.parse('http://127.0.0.1:8000/api/municipio/');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      var municipios = Municipios.fromJson(jsonDecode(resBody));
      return municipios.results!;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }
}
