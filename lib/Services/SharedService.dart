import 'package:e_commerce/Models/Login_Register/login_form_response.dart';
import 'package:e_commerce/Models/User.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedService {
  void SaveData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    if (Config.isLoggedIn) {
      String json = jsonEncode(Config.activeUser);
      sh.setString("user", json);
      print('user saved');
    }
    bool login = Config.isLoggedIn;
    sh.setBool("login", login);
    if (sh.getBool("login") == true) {
      print('login saved');
    }
  }

  Future LoadData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? json = sh.getString("user");
    bool? b = sh.getBool("login");
    if (b! && json != null) {
      Config.user = User.fromJson(jsonDecode(json));
      print('user loaded');
    }
    print('Login state: ' + b.toString());
    Config.login = b;
  }

  void ClearData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.clear();
  }
}
