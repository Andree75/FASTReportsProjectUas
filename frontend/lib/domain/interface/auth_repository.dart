abstract class AuthRepository {
  Future<bool> login(String username, String password);
  Future<bool> register(String fullName, String username, String password);
  Future<void> logout();
  Future<bool> checkLoginStatus();
}
