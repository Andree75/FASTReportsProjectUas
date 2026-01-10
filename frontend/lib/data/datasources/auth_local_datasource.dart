import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUserData(Map<String, dynamic> userMap);
  Future<int?> getCachedUserId();
  Future<String?> getCachedUserName();
  Future<void> clearUserData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUserData(Map<String, dynamic> userMap) async {
    await sharedPreferences.setInt('user_id', userMap['user_id']);
    await sharedPreferences.setString('full_name', userMap['full_name']);
    if (userMap['username'] != null) {
      await sharedPreferences.setString('username', userMap['username']);
    }
  }

  @override
  Future<int?> getCachedUserId() async {
    return sharedPreferences.getInt('user_id');
  }

  @override
  Future<String?> getCachedUserName() async {
    return sharedPreferences.getString('username');
  }

  @override
  Future<void> clearUserData() async {
    await sharedPreferences.clear();
  }
}
