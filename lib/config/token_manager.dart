import 'package:calorie_tracker_app/config/token_storage.dart';
import 'package:calorie_tracker_app/feature/login/login_service.dart';

import '../util/api_response.dart';

class TokenManager {
  final TokenStorage tokenStorage = TokenStorage();

  static final TokenManager _instance = TokenManager._internal();
  factory TokenManager() {
    return _instance;
  }
  TokenManager._internal();

  static Future<String> getToken() async {
    String? token = await TokenManager().tokenStorage.getToken();
    if (token == null) {
      throw Exception("token invalid");
    }
    return token;
  }

  static Future<String?> getTokenIfValid() async {
    if (await TokenManager().checkTokenValidity()) {
      return await TokenManager().tokenStorage.getToken();
    }
    return null;
  }

  Future<bool> checkTokenValidity() async {
    String? token = await tokenStorage.getToken();
    if (token != null) {
      // 发送请求到后端验证令牌
      return await _validateTokenWithServer(token);
    }
    return false;
  }

  Future<bool> refreshToken() async {
    // 实现令牌刷新逻辑
    ApiResponse response = await LoginService().refreshToken(email: "", password: "");
    if (response.message.toUpperCase() == "SUCCESS") {
      String newToken = response.data;
      await tokenStorage.storeToken(newToken);
      return true;
    }
    return false;
  }

  Future<bool> _validateTokenWithServer(String token) async {
    // 假设有一个服务方法来验证令牌
    ApiResponse response = await LoginService().checkToken(token: token);
    return response.message.toUpperCase() == "SUCCESS";
  }
}
