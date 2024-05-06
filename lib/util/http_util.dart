import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart'; // 用于处理文件类型的MIME

class HttpUtil {
  // 发送 GET 请求的函数
  static Future<Map<String, dynamic>> sendGet(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data from GET request: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // 发送 POST 请求的函数（接收JSON数据）
  static Future<Map<String, dynamic>> sendPost(String url, Map<String, dynamic> json) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(json),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // String message = 'Failed to load data from POST request: ${response.statusCode}';
        // throw Exception(message);
        throw Exception(http.Response);
      }
    } catch (e) {
      rethrow;
    }
  }

  // 发送 POST 请求的函数（上传文件）
  static Future<Map<String, dynamic>> sendPostWithFile(String url, File file, String fieldName) async {
    try {
      var uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri);

      // 使用mime包来查找文件的MIME类型
      var mimeTypeData = lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])?.split('/');
      if (mimeTypeData == null) {
        throw Exception("Cannot determine the MIME type of the file");
      }

      // 添加文件
      request.files.add(http.MultipartFile(
        fieldName, // 使用动态传入的字段名
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: file.path.split('/').last,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]), // 使用动态的MIME类型
      ));

      var response = await request.send();
      if (response.statusCode == 200) {
        return jsonDecode(await response.stream.bytesToString());
      } else {
        String message = 'Failed to upload file: ${response.statusCode}';
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
