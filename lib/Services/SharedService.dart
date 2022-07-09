import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:e_commerce/Models/Login_Register/login_form_response.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var keyExists = await APICacheManager().isAPICacheKeyExist('login_details');

    return keyExists;
  }

  // static Future<login_form_response?> loginDetails() async {
  //   var keyExist = await APICacheManager().isAPICacheKeyExist('login_details');

  //   if (keyExist) {
  //     var cacheData = await APICacheManager().getCacheData('login_details');

  //     return login_form_response(cacheData.syncData);
  //   }
  // }
}
