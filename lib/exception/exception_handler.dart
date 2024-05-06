import 'dart:io';

class ExceptionHandler {
  static void handleException(e) {
    // 你可以根据不同类型的异常进行不同的处理
    if (e is HttpException) {
      print('网络请求异常: ${e.message}');
    } else if (e is FormatException) {
      print('格式错误: ${e.message}');
    } else if (e is FileSystemException) {
      print('文件系统错误: ${e.message}');
    } else {
      print('未知异常: ${e.toString()}');
    }

    // 可以添加更多的日志记录或错误上报逻辑
    // Log to external server, send email, etc.
  }
}
