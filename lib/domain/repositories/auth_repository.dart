abstract class AuthRepository {
  Future<bool> authenticate(String username, String password);
}
