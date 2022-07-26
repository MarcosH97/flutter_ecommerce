import 'dart:convert';

import '../Utils/Config.dart';
import 'package:http/http.dart' as http;

class UserRequest {
  int? count;
  Null? next;
  Null? previous;
  List<User>? results;

  UserRequest({this.count, this.next, this.previous, this.results});

  UserRequest.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <User>[];
      json['results'].forEach((v) {
        results!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? name;
  String? password;
  String? direccion;
  String? pais;
  String? ciudad;
  String? codigoPostal;
  String? telefono;
  bool? rss;
  bool? isActive;
  bool? isStaff;
  bool? isSuperuser;
  String? lastLogin;

  User(
      {this.id,
      this.email,
      this.name,
      this.password,
      this.direccion,
      this.pais,
      this.ciudad,
      this.codigoPostal,
      this.telefono,
      this.rss,
      this.isActive,
      this.isStaff,
      this.isSuperuser,
      this.lastLogin});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    direccion = json['direccion'];
    pais = json['pais'];
    ciudad = json['ciudad'];
    codigoPostal = json['codigo_postal'];
    telefono = json['telefono'];
    rss = json['rss'];
    isActive = json['is_active'];
    isStaff = json['is_staff'];
    isSuperuser = json['is_superuser'];
    lastLogin = json['last_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['direccion'] = this.direccion;
    data['pais'] = this.pais;
    data['ciudad'] = this.ciudad;
    data['codigo_postal'] = this.codigoPostal;
    data['telefono'] = this.telefono;
    data['rss'] = this.rss;
    data['is_active'] = this.isActive;
    data['is_staff'] = this.isStaff;
    data['is_superuser'] = this.isSuperuser;
    data['last_login'] = this.lastLogin;
    return data;
  }

  Future<bool> changePassword(String newpw) async {
    var headersList = {
      'Authorization': Config.token,
      'Content-Type': 'application/json'
    };
    var url =
        Uri.parse('https://www.diplomarket.com/backend/user/password/change/');

    var body = {"id": id, "password": "$newpw"};
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      return true;
    } else {
      print(res.reasonPhrase);
      return false;
    }
  }
}
