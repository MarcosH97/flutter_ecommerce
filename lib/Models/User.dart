class User {
  int? id;
  late String email;
  late String password;
  late String name;
  late String direccion;
  int? pais;
  late String ciudad;
  late String codigoPostal;
  late String telefono;
  bool? rss;
  bool? isActive;
  bool? isStaff;
  bool? isSuperuser;
  String? lastLogin;

  User(
      {this.id,
      required this.email,
      required this.password,
      required this.name,
      required this.direccion,
      this.pais,
      required this.ciudad,
      required this.codigoPostal,
      required this.telefono,
      this.rss,
      this.isActive,
      this.isStaff,
      this.isSuperuser,
      this.lastLogin});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
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
    data['password'] = this.password;
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
