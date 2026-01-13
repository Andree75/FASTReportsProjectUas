import 'dart:io';
import '../entities/report.dart';

abstract class ReportRepository {
  Future<List<Report>> getHistory(int userId);

  Future<bool> createReport({
    required int userId,
    required String title,
    required String description,
    required String category,
    required File imageFile,
    String? metadata,
    required String urgency,
    double? lat,
    double? long,
  });
  Future<bool> deleteReport(int reportId);
}
