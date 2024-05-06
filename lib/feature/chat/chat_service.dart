import 'dart:io';

import 'package:calorie_tracker_app/app_config.dart';
import 'package:calorie_tracker_app/util/api_response.dart'; // 用于设置Content-Type
import 'package:calorie_tracker_app/util/http_util.dart';

class ChatService {
  // 上传图片
  Future<ApiResponse> uploadImage(File imageFile) async {
    var url = '$BASE_URL/image';
    Map<String, dynamic> result = await HttpUtil.sendPostWithFile(url, imageFile, 'image');
    return ApiResponse.fromJson(result);
  }

  Future<ApiResponse> chatVersion(String imageName) async {
    Map<String, dynamic> requestBody = {
      'filename': imageName,
    };

    var url = '$BASE_URL/chat/version';
    Map<String, dynamic> result = await HttpUtil.sendPost(url, requestBody);
    return ApiResponse.fromJson(result);
  }
}
