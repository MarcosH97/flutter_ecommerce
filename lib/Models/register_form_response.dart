class register_form_response {
  late int? id;
  late String? email;
  late String? name;
  late String? direccion;
  late int? pais;
  late String? ciudad;
  late String? codigoPostal;
  late String? telefono;
  late bool? rss;
  late bool? isActive;
  late bool? isStaff;
  late bool? isSuperuser;
  late String? lastLogin;

  register_form_response(
      {this.id,
      this.email,
      this.name,
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

  register_form_response.fromJson(Map<String, dynamic> json) {
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
