abstract class IAuthRepository {
  Future<void> login();
  Future<String> getRefreshToken(String code);
  Future<String> getToken(String refreshToken);
}
