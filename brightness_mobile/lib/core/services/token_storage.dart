abstract class TokenStorage {
  Future<String?> getAccessToken();
  Future<void> setAccessToken(String? token);

  Future<String?> getRefreshToken();
  Future<void> setRefreshToken(String? token);
}

class InMemoryTokenStorage implements TokenStorage {
  String? _access;
  String? _refresh;

  @override
  Future<String?> getAccessToken() async => _access;

  @override
  Future<String?> getRefreshToken() async => _refresh;

  @override
  Future<void> setAccessToken(String? token) async {
    _access = token;
  }

  @override
  Future<void> setRefreshToken(String? token) async {
    _refresh = token;
  }
}

