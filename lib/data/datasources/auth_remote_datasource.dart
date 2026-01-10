import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../../core/error/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String username, String password);
  Future<bool> register(String fullName, String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await client.post(
      Uri.parse(ApiConstants.loginEndpoint),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == true) {
        return data['data'];
      } else {
        throw ServerException(data['message']);
      }
    } else {
      throw ServerException("Server Error: ${response.statusCode}");
    }
  }

  @override
  Future<bool> register(
    String fullName,
    String username,
    String password,
  ) async {
    final response = await client.post(
      Uri.parse(ApiConstants.registerEndpoint),
      body: {'full_name': fullName, 'username': username, 'password': password},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == true) {
        return true;
      } else {
        throw ServerException(data['message']);
      }
    } else {
      throw ServerException("Server Error: ${response.statusCode}");
    }
  }
}
