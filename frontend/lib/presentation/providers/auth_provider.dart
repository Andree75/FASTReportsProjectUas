import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../../domain/interface/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository repository;
  AuthProvider({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> login(
    String username,
    String password,
    BuildContext context,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      await repository.login(username, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal Login: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  Future<bool> register(
    String fullName,
    String username,
    String password,
    BuildContext context,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      await repository.register(fullName, username, password);
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registrasi Berhasil! Silakan Login.")),
      );
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    await repository.logout();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  Future<bool> adminLogin(String username, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.adminLoginEndpoint),
        body: {'username': username, 'password': password},
      );
      final data = jsonDecode(response.body);

      _isLoading = false;
      notifyListeners();

      if (data['status'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
