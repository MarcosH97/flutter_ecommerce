import 'package:api_cache_manager/api_cache_manager.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var keyExists = await APICacheManager().isAPICacheKeyExist('login_details');

    return keyExists;
  }
  
}
