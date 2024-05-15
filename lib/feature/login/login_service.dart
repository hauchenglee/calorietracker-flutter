import 'package:calorie_tracker_app/app_config.dart';
import 'package:calorie_tracker_app/util/api_response.dart';
import 'package:calorie_tracker_app/util/http_util.dart';

class LoginService {
  Future<ApiResponse> checkExist({required String email}) async {
    Map<String, dynamic> requestBody = {
      'email': email,
    };

    var url = '$BASE_URL/login';
    Map<String, dynamic> result = await HttpUtil.sendPostNoToken(url, requestBody);
    ApiResponse response = ApiResponse.fromJson(result);
    if (response.message.toUpperCase() != 'SUCCESS') {
      throw Exception(response.message);
    }
    return ApiResponse.fromJson(result);
  }

  Future<ApiResponse> register({required String email, required String password}) async {
    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };

    var url = '$BASE_URL/register';
    Map<String, dynamic> result = await HttpUtil.sendPostNoToken(url, requestBody);
    ApiResponse response = ApiResponse.fromJson(result);
    if (response.message.toUpperCase() != 'SUCCESS') {
      throw Exception(response.message);
    }
    return ApiResponse.fromJson(result);
  }

  Future<ApiResponse> login({required String email, required String password}) async {
    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };

    var url = '$BASE_URL/login';
    Map<String, dynamic> result = await HttpUtil.sendPostNoToken(url, requestBody);
    ApiResponse response = ApiResponse.fromJson(result);
    if (response.message.toUpperCase() != 'SUCCESS') {
      throw Exception(response.message);
    }
    return ApiResponse.fromJson(result);
  }
}
