import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../domain/interface/report_repository.dart';
import '../../domain/entities/report.dart';
import '../../data/models/report_model.dart';
import '../../core/constants/api_constants.dart';

class ReportProvider with ChangeNotifier {
  final ReportRepository repository;

  List<Report> _reports = [];
  bool _isLoading = false;
  String? _errorMessage;

  ReportProvider({required this.repository});

  List<Report> get reports => _reports;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchHistory(int userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _reports = await repository.getHistory(userId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllReports() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(ApiConstants.getHistoryEndpoint),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          List body = data['data'];
          _reports = body.map((e) => ReportModel.fromJson(e)).toList();
        } else {
          _reports = [];
        }
      } else {
        throw "Server Error: ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = e.toString();
      _reports = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateStatus(int reportId, String newStatus) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.updateStatusEndpoint),
        body: {'report_id': reportId.toString(), 'status': newStatus},
      );

      final data = jsonDecode(response.body);
      if (data['status'] == true) {
        final index = _reports.indexWhere((r) => r.id == reportId);
        if (index != -1) {
          await fetchAllReports();
        }
        return true;
      }
    } catch (e) {
      print("Error update status: $e");
    }
    return false;
  }

  Future<bool> createReport({
    required int userId,
    required String title,
    required String description,
    required String category,
    required File imageFile,
    String? metadata,
    required String urgency,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await repository.createReport(
        userId: userId,
        title: title,
        description: description,
        category: category,
        imageFile: imageFile,
        metadata: metadata,
        urgency: urgency,
      );

      _isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteReport(int reportId) async {
    try {
      final success = await repository.deleteReport(reportId);
      if (success) {
        _reports.removeWhere((item) => item.id == reportId);
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Gagal hapus: $e");
    }
    return false;
  }
}
