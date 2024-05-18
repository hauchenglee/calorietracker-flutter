import 'package:calorie_tracker_app/config/token_storage.dart';
import 'package:calorie_tracker_app/feature/login/login_service.dart';

import '../util/api_response.dart';

class TokenManager {
  final TokenStorage tokenStorage = TokenStorage();

  Future<bool> checkTokenValidity() async {
    String? token = await tokenStorage.getToken();
    if (token != null) {
      // 发送请求到后端验证令牌
      return await validateTokenWithServer(token);
    }
    return false;
  }

  Future<bool> validateTokenWithServer(String token) async {
    // 假设有一个服务方法来验证令牌
    ApiResponse response = await LoginService().checkToken(token: token);
    return response.message.toUpperCase() == "SUCCESS";
  }
}
