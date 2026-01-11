import '../../domain/interface/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<bool> login(String username, String password) async {
    try {
      final userMap = await remoteDataSource.login(username, password);
      await localDataSource.cacheUserData(userMap);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> register(
    String fullName,
    String username,
    String password,
  ) async {
    return await remoteDataSource.register(fullName, username, password);
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearUserData();
  }

  @override
  Future<bool> checkLoginStatus() async {
    final userId = await localDataSource.getCachedUserId();
    return userId != null;
  }
}
