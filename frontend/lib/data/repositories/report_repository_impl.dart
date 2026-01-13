import 'dart:io';
import '../../domain/entities/report.dart';
import '../../domain/interface/report_repository.dart';
import '../datasources/report_remote_datasource.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportRemoteDataSource remoteDataSource;

  ReportRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Report>> getHistory(int userId) async {
    return await remoteDataSource.getUserHistory(userId);
  }

  @override
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
  }) async {
    return await remoteDataSource.uploadReport(
      userId: userId,
      title: title,
      description: description,
      category: category,
      imageFile: imageFile,
      metadata: metadata,
      urgency: urgency,
      lat: lat,
      long: long,
    );
  }

  @override
  Future<bool> deleteReport(int reportId) async {
    return await remoteDataSource.deleteReport(reportId);
  }
}
