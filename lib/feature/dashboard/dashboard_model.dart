import 'package:equatable/equatable.dart';

class DashboardModel extends Equatable {
  final String id;
  final String accountId;
  final double calorieLimit;
  final double calorieIntake;
  final double caloriePercent;
  final double carbohydrateLimit;
  final double carbohydrateIntake;
  final double carbohydratePercent;
  final double proteinLimit;
  final double proteinIntake;
  final double proteinPercent;
  final double fatLimit;
  final double fatIntake;
  final double fatPercent;
  final DateTime createDate;
  final DateTime updateDate;

  DashboardModel({
    required this.id,
    required this.accountId,
    required this.calorieLimit,
    required this.calorieIntake,
    required this.caloriePercent,
    required this.carbohydrateLimit,
    required this.carbohydrateIntake,
    required this.carbohydratePercent,
    required this.proteinLimit,
    required this.proteinIntake,
    required this.proteinPercent,
    required this.fatLimit,
    required this.fatIntake,
    required this.fatPercent,
    required this.createDate,
    required this.updateDate,
  });

  @override
  List<Object?> get props => [
    id, accountId, calorieLimit, calorieIntake, caloriePercent,
    carbohydrateLimit, carbohydrateIntake, carbohydratePercent,
    proteinLimit, proteinIntake, proteinPercent,
    fatLimit, fatIntake, fatPercent,
    createDate, updateDate
  ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountId': accountId,
      'calorieLimit': calorieLimit,
      'calorieIntake': calorieIntake,
      'caloriePercent': caloriePercent,
      'carbohydrateLimit': carbohydrateLimit,
      'carbohydrateIntake': carbohydrateIntake,
      'carbohydratePercent': carbohydratePercent,
      'proteinLimit': proteinLimit,
      'proteinIntake': proteinIntake,
      'proteinPercent': proteinPercent,
      'fatLimit': fatLimit,
      'fatIntake': fatIntake,
      'fatPercent': fatPercent,
      'createDate': createDate.toIso8601String(),
      'updateDate': updateDate.toIso8601String(),
    };
  }

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      id: json['id'] as String,
      accountId: json['accountId'] as String,
      calorieLimit: (json['calorieLimit'] as num).toDouble(),
      calorieIntake: (json['calorieIntake'] as num).toDouble(),
      caloriePercent: (json['caloriePercent'] as num).toDouble(),
      carbohydrateLimit: (json['carbohydrateLimit'] as num).toDouble(),
      carbohydrateIntake: (json['carbohydrateIntake'] as num).toDouble(),
      carbohydratePercent: (json['carbohydratePercent'] as num).toDouble(),
      proteinLimit: (json['proteinLimit'] as num).toDouble(),
      proteinIntake: (json['proteinIntake'] as num).toDouble(),
      proteinPercent: (json['proteinPercent'] as num).toDouble(),
      fatLimit: (json['fatLimit'] as num).toDouble(),
      fatIntake: (json['fatIntake'] as num).toDouble(),
      fatPercent: (json['fatPercent'] as num).toDouble(),
      createDate: DateTime.parse(json['createDate'] as String),
      updateDate: DateTime.parse(json['updateDate'] as String),
    );
  }
}
