import 'dart:convert';

import 'package:equatable/equatable.dart';

class AccountModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String password;
  final String status;
  final String token;

  AccountModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.status,
    required this.token,
  });

  // 将对象转换为JSON格式的Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'status': status,
      'token': token,
    };
  }

  // 从JSON格式的Map创建新的Account实例
  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      status: json['status'] as String,
      token: json['token'] as String,
    );
  }

  // 将 JSON 字符串转换为 Account 对象
  static AccountModel fromJsonString(String jsonString) {
    return AccountModel.fromJson(json.decode(jsonString) as Map<String, dynamic>);
  }

  // 将 Account 对象转换为 JSON 字符串
  String toJsonString() {
    return json.encode(toJson());
  }

  @override
  List<Object?> get props => [id, name, email, password, status, token];
}
