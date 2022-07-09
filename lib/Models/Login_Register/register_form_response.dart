import 'package:e_commerce/Models/User.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class register_form_response {
  Future<bool> register(User user) async {
    var headersList = {
      'Authorization': Config.token,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse(Config.apiURL+Config.userAPI);

    var body = {
      "email": user.email,
      "password": user.password,
      "name": user.name,
      "direccion": user.direccion,
      "ciudad": user.ciudad,
      "codigo_postal": user.codigoPostal,
      "telefono": user.telefono
    };
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      // print(user.password);
      // print(resBody);
      return true;
    } else {
      print(res.reasonPhrase);
      return false;
    }
  }
}
