import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:e_commerce/Models/Producto.dart';

class remote {
  Future<List<Producto>?> getData(url) async {
    var client = http.Client();

    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      
    }
  }
}
