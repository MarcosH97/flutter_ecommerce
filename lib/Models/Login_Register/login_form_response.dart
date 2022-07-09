import 'dart:convert';

login_form_response loginResponseJson(String s) =>
    login_form_response.fromJson(json.decode(s));

class login_form_response {
  late int count;
  Null next;
  Null previous;
  late List<Results> results;

  login_form_response(
      {required this.count, this.next, this.previous, required this.results});

  login_form_response.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  late int id;
  late String email;
  late String name;
  late String direccion;
  late int pais;
  late String ciudad;
  late String codigoPostal;
  late String telefono;
  late bool rss;
  late bool isActive;
  late bool isStaff;
  late bool isSuperuser;
  late String lastLogin;

  Results(
      {required this.id,
      required this.email,
      required this.name,
      required this.direccion,
      required this.pais,
      required this.ciudad,
      required this.codigoPostal,
      required this.telefono,
      required this.rss,
      required this.isActive,
      required this.isStaff,
      required this.isSuperuser,
      required this.lastLogin});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
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
}
