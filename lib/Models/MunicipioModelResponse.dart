import 'package:e_commerce/Models/Municipio.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MunicipioModelResponse {
  Future<List<Municipio>> getMunicipios() async {
    var headersList = {
      'Authorization': Config.token
    };
    var url = Uri.parse(Config.apiURL+Config.munAPI);

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
