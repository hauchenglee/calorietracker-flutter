class ChatModel {
  // 定义私有变量，通常在Flutter中我们使用下划线前缀来标识私有字段
  String _message;
  String _description;
  String _name;
  int _calorie;
  int _carbohydrate;
  int _protein;
  int _fat;

  // 构造函数
  ChatModel({
    required String message,
    required String description,
    required String name,
    required int calorie,
    required int carbohydrate,
    required int protein,
    required int fat,
  })  : _message = message,
        _description = description,
        _name = name,
        _calorie = calorie,
        _carbohydrate = carbohydrate,
        _protein = protein,
        _fat = fat;

  // Getter 方法，用于访问私有变量
  String get message => _message;
  String get description => _description;
  String get name => _name;
  int get calorie => _calorie;
  int get carbohydrate => _carbohydrate;
  int get protein => _protein;
  int get fat => _fat;

  // Setter 方法（如果需要修改数据）
  set message(String value) => _message = value;
  set description(String value) => _description = value;
  set name(String value) => _name = value;
  set calorie(int value) => _calorie = value;
  set carbohydrate(int value) => _carbohydrate = value;
  set protein(int value) => _protein = value;
  set fat(int value) => _fat = value;

  // 将对象转换为JSON格式的Map
  Map<String, dynamic> toJson() {
    return {
      'message': _message,
      'description': _description,
      'name': _name,
      'calorie': _calorie,
      'carbohydrate': _carbohydrate,
      'protein': _protein,
      'fat': _fat,
    };
  }

  // 从JSON格式的Map创建新的AIModel实例
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      message: json['message'],
      description: json['description'],
      name: json['name'],
      calorie: json['calorie'],
      carbohydrate: json['carbohydrate'],
      protein: json['protein'],
      fat: json['fat'],
    );
  }
}
