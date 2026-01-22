// import 'dart:convert';
import '../../domain/entities/report.dart';

class ReportModel extends Report {
  ReportModel({
    required int id,
    required int userId,
    required String title,
    required String description,
    required String category,
    required String imagePath,
    required String urgency,
    required String createdAt,
    String? metadata,
    required String status,
  }) : super(
         id: id,
         userId: userId,
         title: title,
         description: description,
         category: category,
         imagePath: imagePath,
         urgency: urgency,
         createdAt: createdAt,
         metadata: metadata,
         status: status,
       );

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: int.parse(json['id'].toString()),
      userId: int.parse(json['user_id'].toString()),
      title: json['title'],
      description: json['description'],
      category: json['category'],
      imagePath: json['image_path'],
      urgency: json['urgency'] ?? 'Biasa',
      createdAt: json['created_at'],
      metadata: json['metadata'],
      status: json['status'] ?? 'Pending',
    );
  }
}
