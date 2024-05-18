import 'package:calorie_tracker_app/app_config.dart';
import 'package:calorie_tracker_app/util/api_response.dart';
import 'package:calorie_tracker_app/util/http_util.dart';

class LoginService {
  Future<ApiResponse> checkExist({required String email}) async {
    var url = '$BASE_URL/check-exist';
    Map<String, dynamic> requestBody = {
      'email': email,
    };

    Map<String, dynamic> result = await HttpUtil.sendPostNoToken(url, requestBody);
    ApiResponse response = ApiResponse.fromJson(result);
    return response;
  }

  Future<ApiResponse> register({required String email, required String password}) async {
    var url = '$BASE_URL/register';
    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };

    Map<String, dynamic> result = await HttpUtil.sendPostNoToken(url, requestBody);
    ApiResponse response = ApiResponse.fromJson(result);
    return response;
  }

  Future<ApiResponse> login({required String email, required String password}) async {
    var url = '$BASE_URL/login';
    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };

    Map<String, dynamic> result = await HttpUtil.sendPostNoToken(url, requestBody);
    ApiResponse response = ApiResponse.fromJson(result);
    return response;
  }
}
