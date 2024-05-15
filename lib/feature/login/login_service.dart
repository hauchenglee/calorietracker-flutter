import 'package:calorie_tracker_app/app_config.dart';
import 'package:calorie_tracker_app/util/api_response.dart';
import 'package:calorie_tracker_app/util/http_util.dart';

class LoginService {
  Future<ApiResponse> register(String email, String password) async {
    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };

    var url = '$BASE_URL/register';
    Map<String, dynamic> result = await HttpUtil.sendPost(url, requestBody);
    return ApiResponse.fromJson(result);
  }

  Future<ApiResponse> login(String email, String password) async {
    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };

    var url = '$BASE_URL/login';
    Map<String, dynamic> result = await HttpUtil.sendPost(url, requestBody);
    return ApiResponse.fromJson(result);
  }
}
