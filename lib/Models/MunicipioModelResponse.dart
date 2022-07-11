
import 'package:e_commerce/Models/Municipio.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MunicipioModelResponse {
  Future<List<Municipio>> getMunicipios() async {
    var headersList = {'Authorization': Config.token};
    var url = Uri.parse(Config.apiURL + Config.munAPI);

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final Municipios body = Municipios.fromJson(jsonDecode(resBody));
      List<Municipio> m = body.results!;
      // print(resBody);
      // print(m[0].nombre);
      return m;
    } else {
      print(res.reasonPhrase);
      return [];
    }
  }
}
