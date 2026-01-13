import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/interface/report_repository.dart';
import '../../domain/entities/report.dart';

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
