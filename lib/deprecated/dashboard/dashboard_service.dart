import 'package:calorie_tracker_app/config/token_manager.dart';

import '../../config/app_config.dart';
import '../../util/api_response.dart';
import '../../util/http_util.dart';

class DashboardService {
  Future<ApiResponse> getDashboardList({required String start, required String end}) async {
    var url = '$BASE_URL/dashboard?start=$start&end=$end';

    String token = await TokenManager.getToken();

    Map<String, dynamic> result = await HttpUtil.sendGet(url, token);
    ApiResponse response = ApiResponse.fromJson(result);
    return response;
  }
}
