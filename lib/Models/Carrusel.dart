import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Utils/Config.dart';

class Carrusel {
  String? titulo;
  String? subtitulo;
  String? imagen;
  String? imgMovil;
  String? enlace;
  String? modo;

  Carrusel(
      {this.titulo,
      this.subtitulo,
      this.imagen,
      this.imgMovil,
      this.enlace,
      this.modo});

  Carrusel.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    subtitulo = json['subtitulo'];
    imagen = json['imagen'];
    imgMovil = json['img_movil'];
    enlace = json['enlace'];
    modo = json['modo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = this.titulo;
    data['subtitulo'] = this.subtitulo;
    data['imagen'] = this.imagen;
    data['img_movil'] = this.imgMovil;
    data['enlace'] = this.enlace;
    data['modo'] = this.modo;
    return data;
  }
}

class CarruselResponse {
  Future<void> getCarrusel() async {
    var headersList = {'Authorization': Config.token};
    var url = Uri.parse('https://www.diplomarket.com/backend/carrusel/');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<dynamic> body = jsonDecode(resBody)['results'];
      body.forEach(
        (element) {
          Carrusel c = Carrusel.fromJson(element);
          if (!Config.carrusel.contains(c)) {
            Config.carrusel.add(c);
          }
        },
      );
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }
}
