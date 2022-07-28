import 'package:e_commerce/Models/Carrito.dart';
import 'package:e_commerce/Models/Destinatario.dart';
import 'package:e_commerce/Services/SharedService.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../User.dart';

class LoginModelResponse {
  late List<User> users;

  static Future<bool> login(String username, String password) async {
    var headersList = {};
    var url = Uri.parse(Config.apiURL + Config.userAuth);

    print(username + '  ' + password);
    var body = {'username': username, 'password': password};
    var req = http.MultipartRequest('POST', url);
    req.fields.addAll(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString(); // print('enter login');

    if (res.statusCode >= 200 && res.statusCode < 300) {
      Config.currentPW = password;
      final data = jsonDecode(resBody);
      getUserInfo(username);
      Config.token = "token " + data['token'];
      // Config().updateCarrito();
      return (true);
    } else {
      // print('login false');
      print(res.reasonPhrase);
      return (false);
    }
  }

  static Future<void> getUserInfo(String umail) async {
    User mainUser;
    var headersList = {'Authorization': Config.token};
    var url = Uri.parse(Config.apiURL + Config.userAPI);

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      UserRequest data = UserRequest.fromJson(jsonDecode(resBody));
      List<User> users = data.results!;

      users.forEach((usuario) async {
        if (usuario.email == umail) {
          Config.user = usuario;
          Config.login = true;
          SharedService().SaveData();
          // Config.kart = await CarritoModelResponse().getCarrito(usuario.id!);
          Config.kart = await CarritoModelResponse().getCarrito(usuario.id!);
        }
      });
      DestinatarioResponse().getDestinatarios();
    } else {
      print(res.reasonPhrase);
    }
  }
}
