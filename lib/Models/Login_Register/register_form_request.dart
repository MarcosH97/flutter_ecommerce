class register_form_request {
  late String password;
  late String email;
  late String name;
  late String direccion;
  late int? pais;
  late String ciudad;
  late String codigoPostal;
  late int telefono;


  register_form_request(
      {required this.password,
      required this.email,
      required this.name,
      required this.direccion,
      this.pais,
      required this.ciudad,
      required this.codigoPostal,
      required this.telefono});

  register_form_request.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    email = json['email'];
    name = json['name'];
    direccion = json['direccion'];
    pais = json['pais'];
    ciudad = json['ciudad'];
    codigoPostal = json['codigo_postal'];
    telefono = json['telefono'];
    

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['email'] = this.email;
    data['name'] = this.name;
    data['direccion'] = this.direccion;
    data['pais'] = this.pais;
    data['ciudad'] = this.ciudad;
    data['codigo_postal'] = this.codigoPostal;
    data['telefono'] = this.telefono;
    return data;
  }
}
