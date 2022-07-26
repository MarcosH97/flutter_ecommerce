import 'package:http/http.dart' as http;

import 'dart:convert';

import '../Utils/Config.dart';

class FAQ {
  int? id;
  String? pregunta;
  String? respuesta;

  FAQ({this.id, this.pregunta, this.respuesta});

  FAQ.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pregunta = json['pregunta'];
    respuesta = json['respuesta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pregunta'] = this.pregunta;
    data['respuesta'] = this.respuesta;
    return data;
  }
}

class FAQModelResponse {
  Future<List<FAQ>> getFAQ() async {
    List<FAQ> lista = [];
    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token
    };
    var url = Uri.parse('https://www.diplomarket.com/backend/faq');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<dynamic> body = jsonDecode(resBody)['results'];
      body.forEach(
        (element) {
          lista.add(FAQ.fromJson(element));
        },
      );
      // print(resBody);
    } else {
      print("FAQ Fail: ${res.reasonPhrase}");
    }
    return lista;
  }
}
