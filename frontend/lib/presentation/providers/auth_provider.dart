import 'package:flutter/material.dart';
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
}
