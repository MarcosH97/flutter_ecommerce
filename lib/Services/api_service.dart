import 'dart:convert';

import 'package:e_commerce/Models/login_form_request.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:http/http.dart' as http;

class api_service {
  static var client = http.Client();

  static Future<bool> login(login_form_request model) async{
    Map<String, String> requestHeaders = 
    {
      'Content-Type' : 'application/jason',
    };
    var url = Uri.http(Config.apiURL, Config.userAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson())
    );

    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }

  }
  //  static Future<bool> register(register_form_request model) async {
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/jason',
  //   };
  //   var url = Uri.http(Config.apiURL, Config.registerAPI);

  //   var response = await client.post(url,
  //       headers: requestHeaders, body: jsonEncode(model.toJson()));

   
  // }
}
