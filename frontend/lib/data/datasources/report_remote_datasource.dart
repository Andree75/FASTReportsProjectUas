import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../models/report_model.dart';

abstract class ReportRemoteDataSource {
  Future<List<ReportModel>> getUserHistory(int userId);
  Future<bool> uploadReport({
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

class ReportRemoteDataSourceImpl implements ReportRemoteDataSource {
  final http.Client client;

  ReportRemoteDataSourceImpl({required this.client});
  @override
  Future<List<ReportModel>> getUserHistory(int userId) async {
    final response = await client.post(
      Uri.parse(ApiConstants.getHistoryEndpoint),
      body: {'user_id': userId.toString()},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == true) {
        final List reports = data['data'];
        return reports.map((json) => ReportModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception("Gagal ambil data server: ${response.statusCode}");
    }
  }

  @override
  Future<bool> uploadReport({
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
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiConstants.uploadReportEndpoint),
    );

    request.fields['user_id'] = userId.toString();
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['category'] = category;
    request.fields['urgency'] = urgency;

    if (metadata != null) {
      request.fields['metadata'] = metadata;
    }
    request.fields['latitude'] = (lat ?? 0.0).toString();
    request.fields['longitude'] = (long ?? 0.0).toString();

    var pic = await http.MultipartFile.fromPath('image', imageFile.path);
    request.files.add(pic);

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['status'] == true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteReport(int reportId) async {
    final response = await client.post(
      Uri.parse(ApiConstants.deleteReportEndpoint),
      body: {'id': reportId.toString()},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['status'] == true;
    }
    return false;
  }
}
