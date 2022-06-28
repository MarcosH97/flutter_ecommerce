import 'package:e_commerce/Utils/Config.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class LoginModelResponse {
  static Future<String> login(String username, String password) async {
    var headersList = {};
    var url = Uri.parse("http://127.0.0.1:8000/autenticacion/");

    var body = {'username': username, 'password': password};
    var req = http.MultipartRequest('POST', url);
    // req.headers.addAll(headersList);
    req.fields.addAll(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    print('enter login');
    if (res.statusCode >= 200 && res.statusCode < 300) {
      print('login true');
      final data = jsonDecode(resBody);
      return (data['token']);
    } else {
      print('login false');
      return (res.reasonPhrase.toString());
    }
  }
}
