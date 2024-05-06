class ApiResponse {
  final String code;
  final String message;
  final dynamic data;

  ApiResponse({
    required this.code,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'],
      message: json['message'],
      data: json['data'], // 直接保持原样，因为它可以是任何类型
    );
  }

  @override
  String toString() {
    return 'ApiResponse{code: $code, message: $message, data: $data}';
  }
}
